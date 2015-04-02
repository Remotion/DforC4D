
module c4d_main;

import std.c.stdio; //printf

import c4d;
import c4d_os;
import c4d_string;
import c4d_vector;
import c4d_resource;

import plugins_main; //PluginMessage  //PluginStart  //PluginEnd

import dllmain; //????  

//-----------------------------------------------------------------------------
//enum API_VERSION = 14000;

//Globals >>>
static __gshared GeResource resource;
static __gshared Filename* path_storage=null; //http://dlang.org/migrate-to-shared.html

void FreeResource() {	resource.Free(); }
ref String GeLoadString(Int32 id) { return resource.LoadString(id); }

//try to export c4d_main
//will be called by C4D !!!
export extern(C) int c4d_main(int action, void* p1, void* p2, void* p3)
{
	static int init_count = 0;
	//printf(">>> c4d_main %i %p %p %p,  %i \n",action,p1,p2,p3, init_count);
	try { //try to catch all exceptions !?

		switch (action) {
			case C4DPL_INIT_VERSION: 
				return C4DPL_VERSION;

			case C4DPL_INIT_SYS:
				init_count += 1;
				if (init_count == 1)
				{
					if (InitOS(p1) < API_VERSION) return C4DPL_ERROR_VERSION;
					if (!p3) return C4DPL_ERROR_VERSION;

					//? path_storage = gNew Filename;
					//? if (path_storage) *path_storage = *cast(Filename*)p3;

					//TODO >>>
					//path_storage = heapAllocate!Filename();
					path_storage = new Filename();//???
					if (path_storage) *path_storage = *cast(Filename*)p3;
					//if (path_storage) printf(" path_storage !!!\n");

					//import c4d_general : GePrint;
					//GePrint(Filename(*cast(Filename*)p3).GetString());

					/+
					///Run unittest only after InitOS() was called! GePrint does not work here !
					version(unittest){
						import core.runtime : runModuleUnitTests;
						printf(" D Unittest's are On, Run: \n");
						const bool res = runModuleUnitTests();
						if(res) printf(" D Unittest's OK.\n");
						else printf(" D Unittest's FAILED!\n");
					}
					+/
				}
				return 1;

			case C4DPL_MESSAGE:
				if (!PluginMessage(cast(Int)p1,p2)) return C4DPL_ERROR;
				return 1;

			case C4DPL_INIT:
				///Run unittest only after InitOS() was called!
				version(unittest){
					import core.runtime : runModuleUnitTests;
					printf(" D Unittest's are On, Run: \n");
					const bool res = runModuleUnitTests();
					if(res) printf(" D Unittest's OK.\n");
					else printf(" D Unittest's FAILED!\n");
				}

				return PluginStart();

			case C4DPL_END:
				init_count -= 1;
				if (init_count == 0) {
					PluginEnd();
					FreeResource();
					
					//TODO >>>
					destroy(path_storage); //???
					//? heapDeallocate(path_storage);
					//? gDelete(path_storage); //TEST !!!
				}
				return 1;

			default:
				break;
		} //switch

	} catch(Throwable t){
		printf(" Throwable catched ! \n");
	}

	return C4DPL_ERROR;
}