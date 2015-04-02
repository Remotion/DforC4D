
module plugins_main;

import std.c.stdio; //printf 
import std.string;

import c4d;
import c4d_os;
import c4d_string;
import c4d_vector;

import c4d_general;


import c4d_main;


//-----------------------------------------------
void SomeTests()
{

	struct S{
		~this(){
			printf(" S dtor \n");
		}
	}
	{
		S s;
		destroy(s); //call dtor
		printf(" fine \n");
	}


	//test only >>>
	VectorTest();

	printf(" ######################## Init ######################## \n");
	GePrint("----------------------------------------------------------------");
	//C4DOS.Ge.Free(cast(void*)123);
	printf(" GetTimer %i \n",C4DOS.Ge.GetTimer() );
	printf(" GetDefaultFPS %i \n",C4DOS.Ge.GetDefaultFPS() );
	printf(" GetCurrentOS %i \n",C4DOS.Ge.GetCurrentOS() );

	GeDebugOut("GeDebugOut %i\n",123);
	GeDebugOut(String("GeDebugOut\n"));

	//C4DOS.Ge.GetTimer()
	{
		String str;
		C4DOS.St.Init(&str);
		//printf(" str %i %i %p %p \n",str.m_size,str.m_len,cast(void*)str.m_txt,cast(void*)str.m_future_enhancements);

		auto text = toStringz("C4D Plugins written in D-Lang >>>"); //Returns a C-style zero-terminated string equivalent to
		C4DOS.St.InitCString(&str,text,-1,STRINGENCODING.STRINGENCODING_XBIT);

		//auto text2 = "C4D Plugins written in D-Lang >>>";
		//printf(" text2 %p %i \n",text2.ptr,text2.length);

		//printf(" str %i %i %p %p \n",str.m_size,str.m_len,str.m_txt,str.m_future_enhancements);

		//printf(" arr %i %i %i \n",(cast(int*)&str)[0],(cast(int*)&str)[1],(cast(int*)&str)[2]);

		C4DOS.Ge.Print(str);
		//printf(" str %i %i %p %p \n",str.m_size,str.m_len,str.m_txt,str.m_future_enhancements);
	}
	{
		String s0 = String("123"); //test
	}
	printf("################################ \n");

	String s1 = String(" test string :) ");
	assert(s1.GetLength()==16);
	//printf(" GetLength %i %i \n ",s1.GetLength(), s1.m_len);
	printf(" GetLength()=%i ,should be 16! \n",s1.GetLength());
	{
		String s2 = s1; //copy 
		assert(s1==s2);
		GePrint(s2);
		//GePrint("Copy");
	} //CRASH !!!

	assert(s1==String(" test string :) "));
	Int32 i1 = 123;
	Int32 i2 = 0;
	MemCopy(&i2,&i1,Int32.sizeof);
	assert(i1==i2);
	printf(" MemCopy %i %i \n",i1,i2);

	String s5 = "s5 test";
	GePrint(s5);
	auto ii = cast(Int32)1;

	C4DOS.Ge.Print(s1);
	//? s1 ~= String(" hm 123") ~ String(" :) ");
	C4DOS.Ge.Print(s1);
	GePrint(s1);
	//C4DOS.Ge.Print(s2);

	s1 += String("test");

	String s3 = String("a ") + String(" b");
	s3 += String(" c");
	GePrint(s3);

	const bool bb = String("123") == String("123");
	if(bb) GePrint("123 == 123");

	const bool bb2 = String("a") < String("b");
	if(bb2) GePrint("a<b");

	Filename fn = "C:/test/some.txt";
	GePrint(fn.GetString());
	String name = "Test";
	String dummy;
	/*if(fn.FileSelect(FILESELECTTYPE_ANYTHING, FILESELECT_LOAD,name,dummy)) {
	GePrint(fn.GetString());
	}*/

	///Some GePrint test 
	GePrint(" OKKKKKKKKKK UTF8 @ ");
	GePrint(" OKKKKKKKKKK UTF16 @ "w);

	GePrint("utf8_4bytes_𠜎 𠜱 𠝹 𠱓 𠱸 𠲖 𠳏 𠳕 𠴕 ");
	GePrint("utf8_4bytes_𠜎 𠜱 𠝹 𠱓 𠱸 𠲖 𠳏 𠳕 𠴕 "w);
	GePrint("utf8_4bytes_𠜎 𠜱 𠝹 𠱓 𠱸 𠲖 𠳏 𠳕 𠴕 "d);


	GePrint("Russian_ЯБГДЖЙ ");
	GePrint("Russian_ЯБГДЖЙ "w);

	GePrint("Japanese_てすと_ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃ ");
	GePrint("Japanese_てすと_ｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃ "w);

	GePrint("Greek_κόσμε");
	GePrint("Greek_κόσμε"w);

	BaseContainer bc = NOTOK;
	bc.SetInt32(1000,123);
	printf(" Int32 %i \n",bc.GetInt32(1000));

	//const GeData gd = bc.GetData(1000);
	auto gd = bc.GetData(1000);
	pragma(msg,typeof(gd).stringof); 

	printf(" Int32 %i \n",gd.GetInt32());

	GeData gg;
	gg.SetFilename(fn);
	GePrint(gg.GetFilename().GetString());

	GePrint("----------------------------------------------------------------");
	printf(" -------------------- \n");

	//writeln("tttt");
}

//extern Bool RegisterAsyncTest();

//==========================================================
//return:  true if the plugin was loaded OK, otherwise false.
Bool PluginStart()
{
	//? SomeTests();

	GePrint(String("PluginPath: ") ~ GeGetPluginPath().GetString());


	printf(" RegisterCommandPlugin >>> \n");
	import test_plugins1;

	TestCommand1 tc1 = new TestCommand1();  //! this looks BAD !!!
	//auto tc1 = heapAllocate!TestCommand1();
	//pragma(msg,typeof(tc1)," ",(tc1.sizeof));


	const Bool res1 = RegisterCommandPlugin(
							 1000243, /* TEST ID */
							 String("<<< File Info >>>"),
							 PLUGINFLAG_COMMAND_OPTION_DIALOG,
							 String(),
							 String(),
							 /*cast(CommandData*)*/tc1 //new TestCommand1 //NewObj!(Command)()
							 );

	if(res1) printf(" RegisterCommandPlugin !! \n");
	else  printf(" NOT RegisterCommandPlugin !! \n");
	


	import asynctest : RegisterAsyncTest;
	//? 
	RegisterAsyncTest();//do not work


	import lookatcamera : RegisterLookAtCamera;
	//? 	
	//? RegisterLookAtCamera();

	return TRUE;
}
//---------------------------------------------------------------------------
void PluginEnd()
{

}

//---------------------------------------------------------------------------
//return: true if you consumed the message, otherwise false.
Bool PluginMessage(Int id, void* data)
{
	//return true; 
	switch (id)
	{
		case C4DPL_INIT_SYS:
			if (!resource.Init()){
				printf(" !resource.Init ! \n");
			 	return false;		// don't start plugin without resource
			}
			// register example datatype. This is happening at the earliest possible time
			//? if (!RegisterExampleDataType())
			//? 	return false;

			// serial hook example; if used must be registered before PluginStart(), best in C4DPL_INIT_SYS
			//if (!RegisterExampleSNHook()) return false;

			return true;
			break;
		case C4DMSG_PRIORITY:
			{
				import console;
				restore_c4d_console(); 
			}
			//react to this message to set a plugin priority (to determine in which order plugins are initialized or loaded
			//SetPluginPriority(data, mypriority);
			return true;
			break;
		case C4DPL_BUILDMENU:
			//react to this message to dynamically enhance the menu
			//EnhanceMainMenu();
			break;

		case C4DPL_COMMANDLINEARGS:
			//sample implementation of command line rendering:
			//void CommandLineRendering(C4DPL_CommandLineArgs* args);
			//CommandLineRendering((C4DPL_CommandLineArgs*)data);

			//react to this message to react to command line arguments on startup
			/*
			{
				C4DPL_CommandLineArgs *args = (C4DPL_CommandLineArgs*)data;
				Int32 i;

				for (i=0;i<args->argc;i++)
				{
					if (!args->argv[i]) continue;

					if (!strcmp(args->argv[i],"--help") || !strcmp(args->argv[i],"-help"))
					{
						// do not clear the entry so that other plugins can make their output!!!
						GePrint("\x01-SDK is here :-)");
					}
					else if (!strcmp(args->argv[i],"-SDK"))
					{
						args->argv[i] = nullptr;
						GePrint("\x01-SDK executed:-)");
					}
					else if (!strcmp(args->argv[i],"-plugincrash"))
					{
						args->argv[i] = nullptr;
						*((Int32*)0) = 1234;
					}
				}
			}
			*/
			break;

		case C4DPL_EDITIMAGE:
			/*{
				C4DPL_EditImage *editimage = (C4DPL_EditImage*)data;
				if (!data) break;
				if (editimage->return_processed) break;
				GePrint("C4DSDK - Edit Image Hook: "+editimage->imagefn->GetString());
				// editimage->return_processed = true; if image was processed
			}*/
			return false;
			break;

		default:
			return FALSE;
	}

	return FALSE; //return true;
}