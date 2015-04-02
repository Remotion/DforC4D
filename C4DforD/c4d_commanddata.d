module c4d_commanddata;

import c4d;
import c4d_os;
import c4d_general;
import c4d_basedata;

public import gui;
/+
// Flags for CommandGadget
enum
{
	CMD_POPUP_RIGHT		= 1,
	CMD_POPUP_BELOW		= 2,
	CMD_PIC				= 4,
	CMD_TOGGLE			= 8,		// soll togglebar sein
	CMD_TEXT			= 16,		// Text
	CMD_SHORTCUT		= 32,		// Shortcut
	CMD_ARROW			= 64,		// Pfeile fuer Menu
	CMD_VERT			= 128,	// vertikale Anordnung von Text und Icon
	CMD_BUTTONLIKE		= 256,	// ist ein Button=true, Menueintrag=false
	CMD_MENU			= 512,	// ist ein Menueintrag, daher keine Eintragung beim Commando, zwecks Updates
	CMD_CYCLE			= 1024,	// bleibt eingerastet
	CMD_EDITPALETTE		= 4096,	// CommandManagerFlag, dieser Button ist im PalettenManager
	CMD_SMALLICONS		= 8192,	// Small icons (textheight)

	CMD_VALUE			= 0x3FFFFFFF,
	CMD_ENABLED			= 0x40000000,

	CMD_
};
+/


enum PLUGINFLAG_COMMAND_HOTKEY =		(1 << 27);
enum PLUGINFLAG_COMMAND_OPTION_DIALOG = (1 << 26);
enum PLUGINFLAG_COMMAND_STICKY =		(1 << 25);
enum PLUGINFLAG_COMMAND_ICONGADGET =	(1 << 24);

enum MSG_COMMANDINFORMATION		= 300001001;
enum TOOLHOTKEY_RECEIVER		= 200000290;	// special tool overwrite for plugins
enum MSG_BODYPAINTEXCHANGE		= 300001002;

//=============================================================================
struct RestoreLayoutSecret
{
	Int32 subid;
};

//=============================================================================
struct CommandInformationData
{
	Int32 command_id;	// read
	Int32 managergroup;	// write
	Int32 parentid;
};

//=============================================================================
//extern (C++) 
class CommandData : BaseData
{
public:
	 this()  { /*printf("CommandData.this >\n");*/ }
	~this()  { /*printf("CommandData.~this <\n");*/ }

	// for overriding ---------------------------------

	//Called when the plugin is selected by the user.
	Bool Execute(BaseDocument* doc) { return true; }

	//Execute the command plugin with the subid that was given by GetSubContainer().
	Bool ExecuteSubID(BaseDocument* doc, Int32 subid) { return false; }

	//Execute the command plugin when the user calls it through its options dialog.
	//Note: Plugins must be registered with PLUGINFLAG_COMMAND_OPTION_DIALOG set.
	Bool ExecuteOptionID(BaseDocument* doc, Int32 plugid, Int32 subid) { return false; }

	//Called to get the state of the command. This affects how it is displayed in menus or tool bars.
	//CMD_ENABLED	Enabled.
	//CMD_VALUE		Checked.
	Int32 GetState(BaseDocument* doc){ return CMD_ENABLED; }


	Bool GetSubContainer(BaseDocument* doc,ref BaseContainer submenu) { return false; }

	Bool RestoreLayout(void* secret) { return true; }

	//does not work!
	String GetScriptName(){ return String(); }

	//Called for messages.
	Bool Message(Int32 type, void* data) { return true; }
};


unittest
{
/+
	class Base {
		int get() { return 1; }
	}

	class Derived : Base {
		int get() { return 2; }
	}

	void test_fn(Base *ptr){
		printf(" get %i \n",ptr.get);
	}

	Derived d = new Derived();
	assert(d.get() == 2);

	//test_fn(cast(Base*)d);
	test_fn(cast(Base*)&d);
+/
}




extern (C++) 
{


extern (C++) 
struct COMMANDPLUGIN //: public STATICPLUGIN
{
	STATICPLUGIN parent; //?
	alias parent this; //? 

	String*			help;
	BaseBitmap* command_icon;

	Bool			function(CommandData self,BaseDocument* doc) Execute;
	Int32			function(CommandData self,BaseDocument* doc) GetState;
	Bool			function(CommandData self,void * secret) RestoreLayout;
	void			function(CommandData self,ref const BaseContainer  bc) MessageEx;
	//String			function(CommandData self) GetScriptName;
	void			function(CommandData self, String* result) GetScriptName;
	Bool			function(CommandData self,BaseDocument* doc, ref BaseContainer  submenu) GetSubContainer;
	Bool			function(CommandData self,BaseDocument* doc, Int32 subid) ExecuteSubID;
	Bool			function(CommandData self,Int32 type, void *data) Message;
	Bool			function(CommandData self,BaseDocument* doc, Int32 plugid, Int32 subid) ExecuteOptionID;

	void*			reserved[(32 - 9) * C4DPL_MEMBERMULTIPLIER - 2];
};

static assert(COMMANDPLUGIN.sizeof==384,COMMANDPLUGIN.sizeof); //PC


struct MANAGERINFORMATION //: public STATICPLUGIN
{
	STATICPLUGIN parent; //?
	alias parent this; //? 

	Int32 info;
	void*	reserved[32 * C4DPL_MEMBERMULTIPLIER - 1];
};

} //extern (C++) 


Bool RegisterCommandPlugin(Int32 id,/*auto ref  const*/in String str, Int32 info,in String iconname,/*auto ref  const*/in String help, CommandData dat)
{
	if (!dat)
		return false;

	Bool ok = false;
	if (iconname.Content())	{
		//! TODO >>>
		/+
		AutoAlloc<BaseBitmap> icon;
		if (icon && icon->Init(GeGetPluginPath() + String("res") + iconname) == IMAGERESULT_OK) {
			ok = RegisterCommandPlugin(id, str, info, icon, help, dat);
		}
		+/
	}else{
		ok = RegisterCommandPlugin(id, str, info, null, help, dat);
	}
	return ok;
}

//extern (C++) {
//extern (C++)
Bool RegisterCommandPlugin(Int32 id,/*auto ref const*/in String str, Int32 info, BaseBitmap* icon,/*auto ref const*/in String help, CommandData dat)
{
	if (!dat)	return false;

	COMMANDPLUGIN np;
	ClearMem(&np, (np.sizeof));//ClearMem(&np, sizeof(np));
	np.adr	= cast(BaseData)dat;
	np.help	= cast(String*)&help;
	np.command_icon	= icon;
	np.info	= info;

	//printf(" mfp > \n");

	np.Destructor		= function(BaseData self){ /*printf("Destructor>>> %p \n",self);*/ self.Destructor(); };

	np.Execute			= function(CommandData self,BaseDocument* doc){ return self.Execute(doc);	};
	np.GetState			= function(CommandData self,BaseDocument* doc){ /*printf("GetState >>> %p %p \n",self, doc);*/ return self.GetState(doc);	};
	np.RestoreLayout	= function(CommandData self,void* secret){ return self.RestoreLayout(secret);	};

	np.Message			= function(CommandData self,Int32 type, void* data){ /*printf("Message >>> %p %i %p \n",self,type,data);*/ return self.Message(type,data);	};

	//? np.GetScriptName	= function(CommandData self) {  return self.GetScriptName();	};
	//np.GetScriptName	= function(CommandData self, String* result) { printf("GetScriptName >>> %p %p \n",self,result); if(result){ (*result) = String(); (*result) = self.GetScriptName(); }	};	
	//? np.GetScriptName	= function(CommandData self, String* result) { if(result != null){ (*result) = self.GetScriptName(); } };	

	np.GetSubContainer	= function(CommandData self,BaseDocument* doc,ref BaseContainer submenu){ return self.GetSubContainer(doc,submenu);	};
	np.ExecuteSubID		= function(CommandData self,BaseDocument* doc, Int32 subid){ return self.ExecuteSubID(doc,subid);	};
	np.ExecuteOptionID	= function(CommandData self,BaseDocument* doc, Int32 plugid, Int32 subid){ return self.ExecuteOptionID(doc,plugid,subid);	};

	//np.Destructor			= &CommandData.Destructor;
	//np.Execute			= &CommandData.Execute;
	//np.GetState			= &CommandData.GetState;
	//np.RestoreLayout		= &CommandData.RestoreLayout;
	//np.Message			= &CommandData.Message;
	//np.GetScriptName		= &CommandData.GetScriptName;
	//np.GetSubContainer	= &CommandData.GetSubContainer;
	//np.ExecuteSubID		= &CommandData.ExecuteSubID;
	//np.ExecuteOptionID	= &CommandData.ExecuteOptionID;

	return GeRegisterPlugin(PLUGINTYPE_COMMAND, id, str, &np, (np.sizeof));
}


Bool RegisterManagerInformation(Int32 id,ref const String str, Int32 info)
{
	MANAGERINFORMATION np;
	ClearMem(&np, (np.sizeof));

	np.adr	= null;
	np.info	= info;

	return GeRegisterPlugin(PLUGINTYPE_MANAGERINFORMATION, id, str, &np, (np.sizeof));
}

//} // extern (C++) 
