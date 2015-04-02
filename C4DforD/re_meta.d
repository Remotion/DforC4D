module re_meta;

import std.conv;
import std.traits;
import core.stdc.stdio : printf;

/// Generic .sizeof alternative which works with both class and non-class types,
/// which makes allocating the proper amount of memory for type instances safer.
/// borrowed from b2util.d
template b2memSizeOf(T) if (is(T == class)) {
	enum b2memSizeOf = __traits(classInstanceSize, T);
}
/// ditto.
template b2memSizeOf(T) if ( ! is(T == class)) {
	enum b2memSizeOf = T.sizeof;
}
/// ditto.
template sizeof(T) if (is(T == class)) {
	enum sizeof = __traits(classInstanceSize, T);
}
/// ditto.
template sizeof(T) if ( ! is(T == class)) {
	enum sizeof = T.sizeof;
}

unittest
{
	struct S{ int i; }
	static assert( sizeof!(S)==sizeof!(int) );

	class C0{ int i; }
	static assert( sizeof!(C0)==b2memSizeOf!(C0) );
	static assert( sizeof!(C0)==32 );

	class C{ int i; }
	static assert( sizeof!(C)==32 );
}

/// Emplace alternative which works with void* rather than void[].
/// borrowed from b2util.d
T b2emplace(T)(void* chunk) if (is(T == class)) {
	return emplace!T(chunk[0 .. b2memSizeOf!T]);
}
/// ditto
T* b2emplace(T)(void* chunk) if ( ! is(T == class)) {
	return emplace!T(chunk[0 .. b2memSizeOf!T]);
}
/// ditto
T b2emplace(T, Args...)(void* chunk, Args args) if (is(T == class)) {
	return emplace!T(chunk[0 .. b2memSizeOf!T], args);
}
/// ditto
T* b2emplace(T, Args...)(void* chunk, Args args) if ( ! is(T == class)) {
	return emplace!T(chunk[0 .. b2memSizeOf!T], args);
}



@property
string idOf(T)() {
	static if (__traits(compiles, { string s = T.stringof; }))
		return T.stringof;
	else
		return __traits(identifier, T);
}



mixin template EnumUpScope(string en, string name)
{
	mixin( "alias "~en~"."~name~" "~name~";" );
}

mixin template EnumUpScope(string en, names...)
{
	static if (names.length > 0) {
		mixin EnumUpScope!(en,names[0]); //call EnumUpScope(string name) specialisation 
		mixin EnumUpScope!(en,names[1 .. $]); //recursive call 
	} 
}

/*
enum TestE {
	E_0 = 0,
	E_1,
	E_2,
};
mixin EnumUpScope!(TestE); //< will expand to 

alias TestE.E_0 E_0;
alias TestE.E_1 E_1;
alias TestE.E_2 E_2;
*/
mixin template EnumUpScope(en) //if ( is(en == enum))
{
	static assert(is(en == enum));
	mixin EnumUpScope!(__traits(identifier,en),__traits(allMembers, en));
}


//-----------------------------------------------------------------------------
/// generates string that contains structur memory layout.
/// use it like this:  pragma(msg, struct_diagram!String);
string struct_diagram(T)() {
	import std.string, std.conv;
	string ret;
	int id = 0;

	static if(is(T==class)){
		// T t = new T; //!bug 
	}else {
		T t;
	}
	int offset = 0;
	foreach(idx, item; t.tupleof) {
		int off = t.tupleof[idx].offsetof;
		int size = t.tupleof[idx].sizeof;

		if(off > offset) {
			// padding
			foreach(i; 0 .. off-offset)
				ret ~= format("%d:",id++)~ format(" internal padding\n");
			offset += off-offset;
		}

		foreach(i; 0 .. size)
			ret ~= format("%d:",id++)~ format(" %s\n", t.tupleof[idx].stringof[2..$]);

		offset += size;
	}

	foreach(i; 0 .. T.sizeof-offset){
		ret ~= format("%d:",id++)~ format(" struct padding to %d\n", T.sizeof);
	}
	return ret;
}

//-----------------------------------------------------------------------------
/+template ReturnTypeRe(func...)
if (func.length == 1/* && isCallable!func && isSomeFunction!func*/ )
{
	static if (isCallable!func){
		static if (is(FunctionTypeOf!func R == return)){
		   alias ReturnTypeRe = R;
		}
	} else {
		alias ReturnTypeRe = void;
	}
}+/



//-----------------------------------------------------------------------------
//return true if all return types are smalles as 8 bytes.
//! unfortunatel right now it work well only if struct has only function pointers.
bool test_return_types_size(alias T)(){
	foreach (int i, id; __traits(allMembers, T) ) {
		//string code = "continue;";
		//if( mixin(" isSomeFunction!(typeof(T." ~ id ~ ")) ")  ) {
		//	code = " if( ReturnType!(typeof(T." ~ id ~ ")).sizeof > 8){ return false; } ";
		//}
		//mixin(code);

		mixin(" if( ReturnType!(typeof(T." ~id~ ")).sizeof > 8){ return false; } "); 
		//mixin(" if( ReturnTypeRe!(typeof(T." ~id~ ")).sizeof > 8){ return false; } "); 
	}
	return true;
}
//pragma(msg,test_return_types!C4D_MovieSaver );


//-----------------------------------------------------------------------------
//return string with all the names of functions with return type bigger as 8 bytes 
// or "" if all functions are OK.
//! unfortunatel right now it work well only if struct has only function pointers.
string wrong_return_types_size_list(alias T)(){
	string str;
	foreach (int i, id; __traits(allMembers, T) ) {
		//mixin(" if( ReturnType!(typeof(T." ~ id ~ ")).sizeof > 8){
		//	  str ~= \"" ~ id ~ "  \" ~ typeof(T." ~ id ~ ").stringof ~ \"\\n\";
		//} "); 


		mixin("  if( ReturnType!(typeof(T." ~id~ ")).sizeof > 8){
			  str ~= ReturnType!(typeof(T." ~id~ ")).stringof ~ \"\\t" ~ id ~ "\" ~ \"\\n\";
		} "); 
	}
	if(str.length == 0) return ""; //OK
	return __traits(identifier,T) ~ " {\n" ~str~ " } //" ~ __traits(identifier,T);
	//return str; //OK
}
//pragma(msg,test_return_types2!C4D_Bitmap );



//http://stackoverflow.com/questions/11058906/struct-vs-class-for-writing-d-wrappers-around-foreign-languages
//=============================================================================
struct Wrapper(T) if(is(T==struct))
{
	auto opDispatch(string fn, Args...)(Args args) const {
		//printf("call function %.*s \n",fn.length,fn.ptr);
		return mixin( "m_st." ~ fn ~ "(args)" );
	}

	auto opDispatch(string fn, Args...)(Args args) {
		static if(Args.length == 0){
			printf("call function %.*s() \n",fn.length,fn.ptr);
		}else{
			string str = "call function " ~ fn ~ "(";
			foreach(int i, a; args){ str ~= to!string(a) ~ ","; }
			str ~= ")";
			printf("%.*s\n",str.length,str.ptr);
		}
		
		return mixin( "m_st." ~ fn ~ "(args)" );
	}
private:
	T m_st;
}



unittest //####################################################################
{


	struct S{
		int foo() const { return 1; }
		int foo1(int i) { return i + 1; }
		int foo2(int i,int b) { return i + b + 1; }
	}

	Wrapper!S  s;

	int i = s.foo();
	assert(i == 1);
	//static assert(i == 1);
	//assert();

	int i1 = s.foo1(2);
	//printf(" %i \n",i2);
	assert(i1 == 3);

	int i2 = s.foo2(2,1);
	assert(i2 == 4);
}



//-----------------------------------------------------------------------------
string ctfe_ftoa(T)(T r) pure
{
	if(__ctfe) {
		import c4d_math;
		import std.string : format;
		if(IsNaN(r)) return "nan";
		else if(!IsFinite(r)){ if(r<0) return "-inf"; else return "+inf"; }
		else if(r < 0.0) return format("-%s.%0.5s",cast(int)abs(r),cast(int)(fract(abs(r)) * 100000) );
		else return format("%s.%0.5s",cast(int)r,cast(int)(fract(r) * 100000) );
	}
	assert(0);
}
static assert(ctfe_ftoa(double.init) == "nan");
static assert(ctfe_ftoa(double.infinity) == "+inf");
static assert(ctfe_ftoa(-double.infinity) == "-inf");

static assert(ctfe_ftoa(0.0001) == "0.00010");

//pragma(msg, ctfe_ftoa(101.12345)); //101.12344
//static assert(ctfe_ftoa(101.12345) == "101.12345");

static assert(ctfe_ftoa(-0.0001) == "-0.00010");

//pragma(msg, ctfe_ftoa(-101.12345));
//static assert(ctfe_ftoa(-101.12345) == "-101.12345"); //-101.12344

