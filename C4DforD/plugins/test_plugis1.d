module test_plugins1;

import c4d;
import c4d_file;
public import c4d_commanddata;
import c4d_general;

import c4d_gui;


enum {
	IDC_START		= 1001,
	IDC_PAUSE		= 1002,
	IDC_STOP		= 1003,
};

enum ID_COMMANDDATA = 1029337;  //test id !!!


//====================================================================
//extern (C++)
class TestDialog : GeDialog
{
private:

public :
	// ----------------------------------------------------------------------------------------------------
	override Bool CreateLayout()
	{
		//printf(" CreateLayout >>> \n");
		// first call the parent instance
		Bool res = GeDialog.CreateLayout();

		SetTitle(String("D SDK Demo"));


		GroupBegin(0,BFH_SCALEFIT|BFV_SCALEFIT,2,0,String(""),BFV_GRIDGROUP_ALLOW_WEIGHTS);
		AddButton(IDC_START,BFH_SCALEFIT|BFV_SCALEFIT,0,0,String("Show"));
		AddButton(IDC_PAUSE,BFH_SCALEFIT|BFV_SCALEFIT,0,0,String("Pause"));
		AddButton(IDC_STOP,BFH_SCALEFIT|BFV_SCALEFIT,0,0,String("Hide"));
		GroupEnd();


		//Enable(IDC_PAUSE,FALSE);

		//if(th.IsRunning())	{    
			//Enable(IDC_START,FALSE);
			//Enable((IDC_STOP),TRUE);
		//}else{	
			Enable((IDC_START),TRUE);
			Enable(IDC_STOP,FALSE);
		//}
		//printf(" CreateLayout <<< \n");

		return res;
	}
	// ----------------------------------------------------------------------------------------------------
	override Bool InitValues()
	{
		//printf("InitValues \n");
		// first call the parent instance
		if (!GeDialog.InitValues())
			return false;



		return true;
	}
	// ----------------------------------------------------------------------------------------------------
	override Bool Command(Int32 id,ref const BaseContainer msg)
	{
		//printf("Command %i \n",id);
		switch (id)
		{
			default: break;

			case IDC_START: //Start
				{    
					//BaseDocument *doc = GetActiveDocument();
					Enable(IDC_START,FALSE);
					Enable(IDC_STOP,TRUE);


					GePrint(" Start ... ");

					import sandox; //TODO 
					RestoreConsole();

					break;
				}
			case IDC_PAUSE: //Pause
				{
					GePrint(" Pause ... ");
				}
				break;
			case IDC_STOP: //Stop
				{

					Enable(IDC_START,TRUE);
					Enable(IDC_STOP,FALSE);

					GePrint(" Stop  ");

					import sandox; //TODO 
					HideConsole();

				}
				break;
		}
		return GeDialog.Command(id, msg);
	}
/+
	override Bool CoreMessage(Int32 id,ref const BaseContainer msg)
	{
		//printf(" CoreMessage %i \n",id);
		switch (id)
		{
			//case EVMSG_DOCUMENTRECALCULATED:
			case EVMSG_CHANGE:
				if (CheckCoreMessage(msg) /*&& !lock*/)
				{
					//DescriptionCustomGui *gad = (DescriptionCustomGui*)FindCustomGui(IDC_AO_DESCRIPTION,CUSTOMGUI_DESCRIPTION);
					/*if (gad && GetActiveDocument())	{
						InitValues();
					}*/
				}
				break;
			default:
				break;
		}
		return GeDialog.CoreMessage(id, msg);
	}
+/
}; //TestDialog



//====================================================================
//extern (C++)
class TestCommand1 : CommandData
{
	TestDialog dlg;
public:
	this()  {
		//printf(" new \n");
		dlg = new TestDialog();
		//printf(" new %p \n",dlg);

		//printf("TestCommand1.this >\n");
	}
	~this() { /*printf("TestCommand1.~this <\n");*/ }

	override Bool Execute(BaseDocument* doc)
	{
		GePrint(" Execute >>>>>> ");
		String userInput = "preset://studio.lib4d/Render/tex/HDRI (Basic044).jpg";
		if (!RenameDialog(&userInput))	{
			return true; // user break
		}

		const Filename fn = (userInput);

		// Print information and content length.
		GePrint(String("Path: ") + fn.GetString());
		GePrint(String("GeFExist: ") + String(GeFExist(fn) ? "true" : "false"));
		
		AutoFree!(BaseFile) fp = BaseFile.Alloc();

		//AutoAlloc!(BaseFile) fp = BaseFile.Alloc();
		//auto fp = AutoAlloc!(BaseFile)();

		//BaseFile *fp = BaseFile.Alloc();
		//scope(exit)  { BaseFile.Free(fp); GePrint("BaseFile.Free "); };

		if (!fp.Open(fn))
		{
			GePrint("File could not be opened.");
			return true;
		}
		GePrint(String("Content-length: ") + String.IntToString(fp.GetLength()));
		
	
		return true;
	}

	override Bool ExecuteOptionID(BaseDocument* doc, Int32 plugid, Int32 subid)
	{ 
		GePrint(" ExecuteOptionID >>>>>> ");

		//printf(" new \n");
		//dlg = new TestDialog();
		//printf(" new %p \n",dlg);
		if(dlg){
			//dlg.InitValues(); //test only
			//BaseContainer result;
			//BaseContainer msg = (123);
			//dlg.Message(msg,result);
			//test(dlg); //OK

			//printf(" open >>> \n");
			//auto res = dlg.Open(DLG_TYPE_MODAL,ID_COMMANDDATA,-1,-1,180,60);
			auto res = dlg.Open(DLG_TYPE_ASYNC,ID_COMMANDDATA,-1,-1,180,100);
			//auto res = dlg.Open(DLG_TYPE_ASYNC,ID_COMMANDDATA);
			//printf(" open %i <<< \n",res);
			return res;
		}

		return true;
	}

	override Bool RestoreLayout(void* secret)
	{
		return dlg.RestoreLayout(ID_COMMANDDATA, 0, secret);
	}

};

