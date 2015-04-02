module c4d_memory;


import c4d;
import c4d_os;

//import std.c.stdlib: malloc;
//import std.c.string: memcpy;
import std.c.string;

import core.vararg;
//TODO >>>

//#define NewObj(T, ...)  new (maxon::DefaultAllocator::Alloc(SIZEOF(T), C4D_MISC_ALLOC_LOCATION)) T(__VA_ARGS__)
//#define NewObjClear(T, ...) new (maxon::DefaultAllocator::AllocClear(SIZEOF(T), C4D_MISC_ALLOC_LOCATION)) T(__VA_ARGS__)

auto NewObj(T)(){ 
	return new T();
}
T* NewObjClear(T)(){
	return new T();
}

T* NewObj(T,P...)(T args){ 
	static if(P.length == 0) {
		return new T(_argptr);
	} else {
		return new T(_argptr);		
	}
}
T* NewObjClear(T,P...)(T args){
	static if(P.length == 0) {
		return new T();
	} else {
		return new T(_argptr);
	}
}


//TODO >>>
alias NewMem = GeAllocTypeNC; //! remove this <<<
alias NewMemClear = GeAllocType; //! remove this <<<
alias DeleteMem   = gDelete; //! remove this <<<


void* GeAlloc( ARG1 )(ARG1 x) { 					return C4DOS.Ge.Alloc(x,__LINE__,__FILE__.ptr); }
void* GeAllocNC( ARG1 )(ARG1 x) { 					return C4DOS.Ge.AllocNC(x,__LINE__,__FILE__.ptr); }
void* GeReallocNC( ARG1, ARG2 )(ARG1 p, ARG2 s) { 	return C4DOS.Ge.ReallocNC(p,s,__LINE__,__FILE__.ptr); }

T* GeAllocType( T, ARG2=int )(ARG2 x) { return cast(T*)(C4DOS.Ge.Alloc(T.sizeof*x,__LINE__,__FILE__.ptr)); }
T* GeAllocTypeNC( T, ARG2 )(ARG2 x) { return cast(T*)(C4DOS.Ge.AllocNC(T.sizeof*x,__LINE__,__FILE__.ptr)); }
T* GeReallocTypeNC( T, ARG2,  ARG3 )(ARG2 p, ARG3 s) { return cast(T*)(C4DOS.Ge.ReallocNC(p,T.sizeof*s,__LINE__,__FILE__.ptr)); }


 void _GeFree(void **Daten) {
	 if (*Daten) {	 C4DOS.Ge.Free(*Daten);	 }
	 *Daten=null;
 }

 void GeFree( T )(T x) {  _GeFree(cast(void **)(&x)); }

 // Instead of replacing the delete operator use a template which calls the destructor manually and frees the memory
 void gDelete(T)(ref T *v )
 {
	 if (v) {
		 destroy(v); //call dtor //v.dtor;
		 C4DOS.Ge.Free( v );	// operator delete( v, std::nothrow, 0, NULL );
		 v = null;
	 }
 }

nothrow pure @nogc
void ClearMem(void* d, Int size, Int32 value = 0){
	memset(d, value & 0xFF, size);
}

nothrow pure @nogc
void CopyMem(const void* s, void* d, Int size){
	if (s && d && size){
		memcpy(d, s, size);
	}
}


nothrow pure @nogc
void MemCopy(void* d, const void* s, Int size){
	if (s && d && size){
		memcpy(d, s, size);
	}
}

//=============================================================================
struct AutoAlloc(TYPE)
{
	TYPE *ptr;
private:
	//const AutoAlloc<TYPE>& operator = (const AutoAlloc<TYPE> &p);
	//AutoAlloc(const AutoAlloc<TYPE> &p);
	@disable this(this);
public:
	alias ptr this;

	@disable this();
	//this()						{ this.ptr = TYPE.Alloc(); }

	this(Args...)(Args args)		{ printf("Args %i \n",Args.length); }
	//? this(Int32 id)				{ this.ptr = TYPE.Alloc(id); }
	//? this(Int32 p1, Int32 p2)	{ this.ptr = TYPE.Alloc(p1,p2); }

	this(TYPE* initptr)				{ this.ptr = initptr; }
	this(ref TYPE* p)				{ this.ptr = p;	p = null;	}

	~this()							{ TYPE.Free(ptr); ptr = null; }


	bool isValid() const pure nothrow   { return this.ptr !is null;	}
	TYPE* release() pure nothrow {
		scope(exit) this.ptr = null;
		return this.ptr;
	}
	TYPE *Release() pure nothrow 		{ TYPE *tmp=ptr; ptr=null; return tmp; }

	void Free()							{ TYPE.Free(ptr); ptr=null; }
	void Reset(TYPE *p = NULL)			{ if(ptr != p){ Free(); ptr=p; } }
	TYPE* Get()							{ return ptr; } 
};
AutoAlloc!(T) move(T)(ref AutoAlloc!(T) uniq) {
	return AutoAlloc!(T)(uniq.release());
}


//=============================================================================
struct AutoFree(TYPE)
{
	TYPE *ptr;
private:
	@disable this(this);
public:
	alias ptr this;

	@disable this();

	this(TYPE* initptr)					{ this.ptr = initptr; }
	this(ref TYPE* p)					{ this.ptr = p;	p = null;	}

	~this()								{ TYPE.Free(ptr); ptr = null; }

	bool isValid() const pure nothrow   { return this.ptr !is null;	}
	TYPE* release() pure nothrow {
		scope(exit) this.ptr = null;
		return this.ptr;
	}
	TYPE *Release() pure nothrow 		{ TYPE *tmp=ptr; ptr=null; return tmp; }

	void Free()							{ TYPE.Free(ptr); ptr=null; }
	void Reset(TYPE *p = NULL)			{ if(ptr != p){ Free(); ptr=p; } }
	TYPE* Get()							{ return ptr; } 
};
AutoFree!(T) move(T)(ref AutoFree!(T) uniq) {
	return AutoFree!(T)(uniq.release());
}


/// http://wiki.dlang.org/Memory_Management#Explicit_Class_Instance_Allocation
T heapAllocate(T, Args...) (Args args) 
{
	import std.conv : emplace;
	import core.stdc.stdlib : malloc;
	import core.memory : GC;
	import core.stdc.stdio : printf;

	// get class size of class object in bytes
	static if(is(T==class)){
		auto size = __traits(classInstanceSize, T);
	} 
	static if(is(T==struct)){
		auto size = T.sizeof; //test
	}

	// allocate memory for the object
	auto memory = malloc(size)[0..size];
	if(!memory)
	{
		import core.exception : onOutOfMemoryError;
		onOutOfMemoryError();
	}                    

	printf("Memory allocated\n");

	// notify garbage collector that it should scan this memory
	GC.addRange(memory.ptr, size); //ptr ???

	// call T's constructor and emplace instance on
	// newly allocated memory
	return emplace!(T, Args)(memory, args);                                    
}

void heapDeallocate(T)(T obj) 
{
	import core.stdc.stdlib : free;
	import core.memory : GC;
	import core.stdc.stdio : printf;

	// calls obj's destructor
	destroy(obj); 

	// garbage collector should no longer scan this memory
	GC.removeRange(cast(void*)obj);

	// free memory occupied by object
	free(cast(void*)obj);

	printf("Memory deallocated\n");
}

//=============================================================================
unittest
{
	import core.stdc.stdio;
	import std.conv;
	//import c4d_general : GePrint;
	if(C4DOS) {
/*		
		int *i = GeAllocType!int(128000); //! Leak
		//GeFree(i);
		printf(" memory %p \n",i);

		auto p2 = GeAllocTypeNC!int(128000);
		auto p3 = GeReallocTypeNC!int(p2,128000);

		GeFree(p3);
*/
	}
}