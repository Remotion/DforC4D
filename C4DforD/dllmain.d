module dllmain;

import std.c.windows.windows;
import core.sys.windows.dll;
import core.runtime; // http://dlang.org/phobos/core_runtime.html 
import core.exception; // http://dlang.org/phobos/core_exception.html 
import std.c.stdio;
//import std.string;
//import std.utf;
//import core.vararg;

__gshared HINSTANCE g_hInst;

/*extern (C)	//this is from D1 ?
{
	void gc_init(); // initialize GC
	void gc_term(); // shut down GC
	void _minit();  // initialize module list
	void _moduleCtor(); //rt_moduleCtor();  // run module constructors
	void _moduleUnitTests(); // run module unit tests
}*/

// http://digitalmars.com/d/1.0/dll.html
// http://dlang.org/dll.html
// http://www.dsource.org/projects/tango/wiki/TutDLL
// http://spottedtiger.tripod.com/D_Language/D_Demystifying_D_DLLs1_XP.html

extern (Windows)
BOOL DllMain(HINSTANCE hInstance, ULONG ulReason, LPVOID pvReserved)
{
	//printf(">> DllMain %p %i \n",hInstance,ulReason);
	final switch (ulReason)
	{
	case DLL_PROCESS_ATTACH:
		g_hInst = hInstance;
		assertHandler = &assertHandlerC4D; //replace default assert handler
		//Runtime.traceHandler = &traceHandlerC4D; //replace default exception trace handler
		//rt_trapExceptions = false;

		dll_process_attach( hInstance, true );
		/*version(unittest){
			printf(" D Unittest's are On \n");
			runModuleUnitTests();
		}*/
		break;

	case DLL_PROCESS_DETACH:
		dll_process_detach( hInstance, true );
		break;

	case DLL_THREAD_ATTACH:
		dll_thread_attach( true, true );
		break;

	case DLL_THREAD_DETACH:
		dll_thread_detach( true, true );
		break;
	}
	return true;
}

//-----------------------------------------------------------------------------
void assertHandlerC4D(string file, size_t line, string msg) nothrow
{
	printf(" D ASSERT ");
	if(file !is null && file.length > 0){
		printf("in file: '%.*s' ",file.length,file.ptr);
	}
	printf(" line: %i ",line);
	if(msg !is null && msg.length > 0){
		printf("msg: '%.*s' \n",msg.length,msg.ptr);
	}
/+
	import c4d_os;
	if(C4DOS && (file !is null && file.length > 0)){
		C4DOS.Ge.GeDebugBreak(cast(int)line, cast(byte*)file.ptr); //???
	}
	+/
} 


/+
///Exception callbacks TODO:
/**
* A callback for array bounds errors in D.  A RangeError will be thrown.
*
* Params:
*  file = The name of the file that signaled this error.
*  line = The line number on which this error occurred.
*
* Throws:
*  RangeError.
*/
extern (C) void onRangeError( string file = __FILE__, size_t line = __LINE__ ) /*@safe pure*/ nothrow
{
	printf("onRangeError file: '%.*s' line: %i \n",file.length,file.ptr,line);
	throw new RangeError( file, line, null );
}
+/

static if(0) {
//! TODO >>>
/// Throw a D object.
extern (C) void _d_throwc(Object *h)
{
	//import rt.deh_win64_posix;
	printf("_d_throwc \n");

	size_t regebp;

	debug
	{
		printf("_d_throw(h = %p, &h = %p)\n", h, &h);
		printf("\tvptr = %p\n", *cast(void **)h);
	}

	version (D_InlineAsm_X86)
		asm
		{
			mov regebp,EBP ;
		}
	else version (D_InlineAsm_X86_64)
		asm
		{
			mov regebp,RBP ;
		}
	else
		static assert(0);
/+
	_d_createTrace(h);

//static uint abc;
//if (++abc == 2) *(char *)0=0;

//int count = 0;
	while (1) // for each function on the stack
	{
		size_t retaddr;

		regebp = __eh_find_caller(regebp,&retaddr);
		if (!regebp)
		{ // if end of call chain
			debug printf("end of call chain\n");
			break;
		}

		debug printf("found caller, EBP = %p, retaddr = %p\n", regebp, retaddr);
//if (++count == 12) *(char*)0=0;
		auto func_table = __eh_finddata(cast(void *)retaddr); // find static data associated with function
		auto handler_table = func_table ? func_table.handlertable : null;
		if (!handler_table) // if no static data
		{
			debug printf("no handler table\n");
			continue;
		}
		auto funcoffset = cast(size_t)func_table.fptr;
		version (Win64)
		{
			/* If linked with /DEBUG, the linker rewrites it so the function pointer points
* to a JMP to the actual code. The address will be in the actual code, so we
* need to follow the JMP.
*/
			if ((cast(ubyte*)funcoffset)[0] == 0xE9)
			{ // JMP target = RIP of next instruction + signed 32 bit displacement
				funcoffset = funcoffset + 5 + *cast(int*)(funcoffset + 1);
			}
		}
		auto spoff = handler_table.espoffset;
		auto retoffset = handler_table.retoffset;

		debug
		{
			printf("retaddr = %p\n", retaddr);
			printf("regebp=%p, funcoffset=%p, spoff=x%x, retoffset=x%x\n",
			regebp,funcoffset,spoff,retoffset);
		}

		// Find start index for retaddr in static data
		auto dim = handler_table.nhandlers;

		debug
		{
			printf("handler_info[%d]:\n", dim);
			for (int i = 0; i < dim; i++)
			{
				auto phi = &handler_table.handler_info.ptr[i];
				printf("\t[%d]: offset = x%04x, endoffset = x%04x, prev_index = %d, cioffset = x%04x, finally_offset = %x\n",
						i, phi.offset, phi.endoffset, phi.prev_index, phi.cioffset, phi.finally_offset);
			}
		}

		auto index = -1;
		for (int i = 0; i < dim; i++)
		{
			auto phi = &handler_table.handler_info.ptr[i];

			debug printf("i = %d, phi.offset = %04x\n", i, funcoffset + phi.offset);
			if (retaddr > funcoffset + phi.offset &&
				retaddr <= funcoffset + phi.endoffset)
				index = i;
		}
		debug printf("index = %d\n", index);

		if (dim)
		{
			auto phi = &handler_table.handler_info.ptr[index+1];
			debug printf("next finally_offset %p\n", phi.finally_offset);
			auto prev = cast(InFlight*) &__inflight;
			auto curr = prev.next;

			if (curr !is null && curr.addr == cast(void*)(funcoffset + phi.finally_offset))
			{
				auto e = cast(Error)(cast(Throwable) h);
				if (e !is null && (cast(Error) curr.t) is null)
				{
					debug printf("new error %p bypassing inflight %p\n", h, curr.t);

					e.bypassedException = curr.t;
					prev.next = curr.next;
					//h = cast(Object*) t;
				}
				else
				{
					debug printf("replacing thrown %p with inflight %p\n", h, __inflight.t);

					auto t = curr.t;
					auto n = curr.t;

					while (n.next)
						n = n.next;
					n.next = cast(Throwable) h;
					prev.next = curr.next;
					h = cast(Object*) t;
				}
			}
		}

		// walk through handler table, checking each handler
		// with an index smaller than the current table_index
		int prev_ndx;
		for (auto ndx = index; ndx != -1; ndx = prev_ndx)
		{
			auto phi = &handler_table.handler_info.ptr[ndx];
			prev_ndx = phi.prev_index;
			if (phi.cioffset)
			{
				// this is a catch handler (no finally)

				auto pci = cast(DCatchInfo *)(cast(char *)handler_table + phi.cioffset);
				auto ncatches = pci.ncatches;
				for (int i = 0; i < ncatches; i++)
				{
					auto ci = **cast(ClassInfo **)h;

					auto pcb = &pci.catch_block.ptr[i];

					if (_d_isbaseof(ci, pcb.type))
					{
						// Matched the catch type, so we've found the handler.

						// Initialize catch variable
						*cast(void **)(regebp + (pcb.bpoffset)) = h;

						// Jump to catch block. Does not return.
						{
							size_t catch_esp;
							fp_t catch_addr;

							catch_addr = cast(fp_t)(funcoffset + pcb.codeoffset);
							catch_esp = regebp - handler_table.espoffset - fp_t.sizeof;
							version (D_InlineAsm_X86)
								asm
								{
									mov EAX,catch_esp ;
									mov ECX,catch_addr ;
									mov [EAX],ECX ;
									mov EBP,regebp ;
									mov ESP,EAX ; // reset stack
									ret ; // jump to catch block
								}
							else version (D_InlineAsm_X86_64)
								asm
								{
									mov RAX,catch_esp ;
									mov RCX,catch_esp ;
									mov RCX,catch_addr ;
									mov [RAX],RCX ;
									mov RBP,regebp ;
									mov RSP,RAX ; // reset stack
									ret ; // jump to catch block
								}
							else
								static assert(0);
						}
					}
				}
			}
			else if (phi.finally_offset)
			{
				// Call finally block
				// Note that it is unnecessary to adjust the ESP, as the finally block
				// accesses all items on the stack as relative to EBP.
				debug printf("calling finally_offset %p\n", phi.finally_offset);

				auto blockaddr = cast(void*)(funcoffset + phi.finally_offset);
				InFlight inflight;

				inflight.addr = blockaddr;
				inflight.next = __inflight;
				inflight.t = cast(Throwable) h;
				__inflight = &inflight;

				version (OSX)
				{
					version (D_InlineAsm_X86)
						asm
						{
							sub ESP,4 ;
							push EBX ;
							mov EBX,blockaddr ;
							push EBP ;
							mov EBP,regebp ;
							call EBX ;
							pop EBP ;
							pop EBX ;
							add ESP,4 ;
						}
					else version (D_InlineAsm_X86_64)
						asm
						{
							sub RSP,8 ;
							push RBX ;
							mov RBX,blockaddr ;
							push RBP ;
							mov RBP,regebp ;
							call RBX ;
							pop RBP ;
							pop RBX ;
							add RSP,8 ;
						}
					else
						static assert(0);
				}
				else
				{
					version (D_InlineAsm_X86)
						asm
						{
							push EBX ;
							mov EBX,blockaddr ;
							push EBP ;
							mov EBP,regebp ;
							call EBX ;
							pop EBP ;
							pop EBX ;
						}
					else version (D_InlineAsm_X86_64)
						asm
						{
							sub RSP,8 ;
							push RBX ;
							mov RBX,blockaddr ;
							push RBP ;
							mov RBP,regebp ;
							call RBX ;
							pop RBP ;
							pop RBX ;
							add RSP,8 ;
						}
					else
						static assert(0);
				}

				if (__inflight is &inflight)
					__inflight = __inflight.next;
			}
		}
	}
	terminate();

	+/
}

}

//-----------------------------------------------------------------------------
Throwable.TraceInfo traceHandlerC4D( void* ptr = null ) //TODO >>>
{
	printf(" traceHandlerC4D %p \n",ptr);


	static if( __traits( compiles, backtrace ) )
	{
		import core.demangle;
		import core.stdc.stdlib : free;
		import core.stdc.string : strlen, memchr, memmove;

		class DefaultTraceInfo : Throwable.TraceInfo
		{
			this()
			{
				static enum MAXFRAMES = 128;
				void*[MAXFRAMES]  callstack;
				numframes = 0; //backtrace( callstack, MAXFRAMES );
				if (numframes < 2) // backtrace() failed, do it ourselves
				{
					static void** getBasePtr()
					{
						version( D_InlineAsm_X86 )
							asm { naked; mov EAX, EBP; ret; }
						else
							version( D_InlineAsm_X86_64 )
								asm { naked; mov RAX, RBP; ret; }
						else
							return null;
					}

					auto  stackTop    = getBasePtr();
					auto  stackBottom = cast(void**) thread_stackBottom();
					void* dummy;

					if( stackTop && &dummy < stackTop && stackTop < stackBottom )
					{
						auto stackPtr = stackTop;

						for( numframes = 0; stackTop <= stackPtr &&
							 stackPtr < stackBottom &&
							numframes < MAXFRAMES; )
						{
							callstack[numframes++] = *(stackPtr + 1);
							stackPtr = cast(void**) *stackPtr;
						}
					}
				}
				framelist = backtrace_symbols( callstack.ptr, numframes );
			}

			~this()
			{
				free( framelist );
			}

			override int opApply( scope int delegate(ref const(char[])) dg ) const
			{
				return opApply( (ref size_t, ref const(char[]) buf)
								{
									return dg( buf );
								} );
			}

			override int opApply( scope int delegate(ref size_t, ref const(char[])) dg ) const
			{
				version( Posix )
				{
					// NOTE: The first 5 frames with the current implementation are
					//       inside core.runtime and the object code, so eliminate
					//       these for readability.  The alternative would be to
					//       exclude the first N frames that are in a list of
					//       mangled function names.
					static enum FIRSTFRAME = 5;
				}
				else
				{
					// NOTE: On Windows, the number of frames to exclude is based on
					//       whether the exception is user or system-generated, so
					//       it may be necessary to exclude a list of function names
					//       instead.
					static enum FIRSTFRAME = 0;
				}
				int ret = 0;

				for( int i = FIRSTFRAME; i < numframes; ++i )
				{
					char[4096] fixbuf;
					auto buf = framelist[i][0 .. strlen(framelist[i])];
					auto pos = cast(size_t)(i - FIRSTFRAME);
					buf = fixline( buf, fixbuf );
					ret = dg( pos, buf );
					if( ret )
						break;
				}
				return ret;
			}

			override string toString() const
			{
				string buf;
				foreach( i, line; this )
					buf ~= i ? "\n" ~ line : line;
				return buf;
			}

		private:
			int     numframes;
			char**  framelist;

		private:
			const(char)[] fixline( const(char)[] buf, ref char[4096] fixbuf ) const
			{
				size_t symBeg, symEnd;
				version( OSX )
				{
					// format is:
					//  1  module    0x00000000 D6module4funcAFZv + 0
					for( size_t i = 0, n = 0; i < buf.length; i++ )
					{
						if( ' ' == buf[i] )
						{
							n++;
							while( i < buf.length && ' ' == buf[i] )
								i++;
							if( 3 > n )
								continue;
							symBeg = i;
							while( i < buf.length && ' ' != buf[i] )
								i++;
							symEnd = i;
							break;
						}
					}
				}
				else version( linux )
				{
					// format is:  module(_D6module4funcAFZv) [0x00000000]
					// or:         module(_D6module4funcAFZv+0x78) [0x00000000]
					auto bptr = cast(char*) memchr( buf.ptr, '(', buf.length );
					auto eptr = cast(char*) memchr( buf.ptr, ')', buf.length );
					auto pptr = cast(char*) memchr( buf.ptr, '+', buf.length );

					if (pptr && pptr < eptr)
						eptr = pptr;

					if( bptr++ && eptr )
					{
						symBeg = bptr - buf.ptr;
						symEnd = eptr - buf.ptr;
					}
				}
				else version( FreeBSD )
				{
					// format is: 0x00000000 <_D6module4funcAFZv+0x78> at module
					auto bptr = cast(char*) memchr( buf.ptr, '<', buf.length );
					auto eptr = cast(char*) memchr( buf.ptr, '+', buf.length );

					if( bptr++ && eptr )
					{
						symBeg = bptr - buf.ptr;
						symEnd = eptr - buf.ptr;
					}
				}
				else
				{
					// fallthrough
				}

				assert(symBeg < buf.length && symEnd < buf.length);
				assert(symBeg < symEnd);

				enum min = (size_t a, size_t b) => a <= b ? a : b;
				if (symBeg == symEnd || symBeg >= fixbuf.length)
				{
					immutable len = min(buf.length, fixbuf.length);
					fixbuf[0 .. len] = buf[0 .. len];
					return fixbuf[0 .. len];
				}
				else
				{
					fixbuf[0 .. symBeg] = buf[0 .. symBeg];

					auto sym = demangle(buf[symBeg .. symEnd], fixbuf[symBeg .. $]);

					if (sym.ptr !is fixbuf.ptr + symBeg)
					{
						// demangle reallocated the buffer, copy the symbol to fixbuf
						immutable len = min(fixbuf.length - symBeg, sym.length);
						memmove(fixbuf.ptr + symBeg, sym.ptr, len);
						if (symBeg + len == fixbuf.length)
							return fixbuf[];
					}

					immutable pos = symBeg + sym.length;
					assert(pos < fixbuf.length);
					immutable tail = buf.length - symEnd;
					immutable len = min(fixbuf.length - pos, tail);
					fixbuf[pos .. pos + len] = buf[symEnd .. symEnd + len];
					return fixbuf[0 .. pos + len];
				}
			}
		}

		return new DefaultTraceInfo;
	}
	else static if( __traits( compiles, new StackTrace(0, null) ) )
	{
		version (Win64)
		{
			static enum FIRSTFRAME = 4;
		}
		else
		{
			static enum FIRSTFRAME = 0;
		}
		auto s = new StackTrace(FIRSTFRAME, cast(CONTEXT*)ptr);
		return s;
	}
	else
	{
		return null;
	}
}