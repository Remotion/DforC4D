
//Remotion c4d for D module >>>

module c4d_string;

import c4d;
import c4d_os;
public import c4d_memory;

import std.c.stdio; //printf
import std.string;
import std.utf;


//=============================================================================
//extern (C++):
struct String
{
//nothrow: //TODO
//@nogc: //TODO

//private:
	/*
	Int32 dummy1 = 0;
	Int32 dummy2 = 0;
	void* dummy3 = null;
	void* dummy4 = null;
	*/

//static if(0) {s
	union{
		struct {
			Int32	m_size = 0; 		// actual allocated size / capacity() //min 16
			Int32	m_len  = 0; 		// number of characters / size()
			UInt16*	m_txt = null; 		//UInt16 data
			void*	m_future_enhancements = null; //unused !?
		}
		void* ptr;	//only this pointer seems to be used in R16 !?
	}
/*} else {	
	UInt16*	m_txt = null; 		//UInt16 data
	Int32	m_size = 0; 		// actual allocated size / capacity() //min 16
	Int32	m_len  = 0; 		// number of characters / size()
	void*	m_future_enhancements = null;
}*/

public:
	//this(){ C4DOS.S.Init(&this); }  // error, cannot implement default ctor for structs
	//@disable this();
	/*
	@property void from_string()(auto ref const string str) { 
		C4DOS.St.Init(&this);
		C4DOS.St.InitCString(&this, str.ptr, cast(Int32)str.length, STRINGENCODING_UTF8);
	}
	alias from_string this; //alias this !!!
	*/

	//copy constructor / postblit
static if(0){
	@disable this(this);  // disabling makes String not copyable
}else{
	nothrow @nogc
	this(this) {
		String tmp;
		MemCopy(&tmp,&this,String.sizeof);

		C4DOS.St.Init(&this); //important 
		C4DOS.St.CopyTo(&tmp, &this);

		//printf(" from %i %i %p \n",tmp.m_size,tmp.m_len,tmp.m_txt);
		//printf(" copy %i %i %p \n",this.m_size,this.m_len,this.m_txt);

		//tmp.dummy1 = 0;
		//tmp.dummy2 = 0;
		//tmp.dummy3 = null;
		//tmp.dummy4 = null; 
		tmp.m_size = 0;
		tmp.m_len = 0;
		tmp.m_txt = null;
		tmp.m_future_enhancements = null;
	}
}
	nothrow @nogc
	~this() { /// dtor 
		if(!__ctfe){
			//printf(" dtor %i %i %p %p %i \n"
			//	   ,cast(int)m_size   ,cast(int)m_len  ,cast(void*)m_txt  ,m_future_enhancements  ,m_txt - m_future_enhancements); //TODO 
			//if(m_txt) printf(" dtor %i %i %p  \n"  ,cast(int)m_size ,cast(int)m_len,cast(void*)m_txt); //TODO 

			C4DOS.St.Flush(&this);
		}
		m_size = 0;
		m_len  = 0;
		m_txt  = null;
		m_future_enhancements = null;
	}

	
	// operator =
	/+ref String opAssign()(auto ref String rhs)
	{
		printf(" copy opAssign \n");

		C4DOS.St.Init(&this);
		C4DOS.St.CopyTo(&rhs, &this);
		return this;
	}+/

	ref String opAssign()(auto ref string str) //from utf8 string 
	{
		C4DOS.St.Init(&this);
		C4DOS.St.InitCString(&this, str.ptr, cast(Int32)str.length, STRINGENCODING_UTF8);
		return this;
	}
	

	/*static String opCall() { //this()  
		String n; 
		//C4DOS.S.Init(&n); //? work ???
		return n;
	}*/


	//? this(void* n = null){ 	}
	/*this(T)(T t) {
	//if(T is void*){
	//if(is(T == null)){
		
	}*/

	this()(auto ref const String cs) //! auto ref
	{
		//? printf(" copy 2 \n");
		C4DOS.St.Init(&this);
		C4DOS.St.CopyTo(&cs, &this);
	}

	//from utf16 array
	this(const UInt16* s, Int32 size = -1) 	nothrow @nogc
	{
		C4DOS.St.Init(&this);
		C4DOS.St.SetUcBlock(&this, s, size);
	}


	this(const(Char16)* s, Int32 size = -1) nothrow @nogc
	{
		C4DOS.St.Init(&this);
		C4DOS.St.SetUcBlock(&this, cast(UInt16*)s, size);
	}

	//from utf16 string 
	this(ref const wstring str)
	{
		C4DOS.St.Init(&this);
		C4DOS.St.SetUcBlock(&this, cast(UInt16*)str.ptr, cast(Int32)str.length);
	}
	this(in wstring str)
	{
		C4DOS.St.Init(&this);
		C4DOS.St.SetUcBlock(&this, cast(UInt16*)str.ptr, cast(Int32)str.length);
	}


	//from utf8 array 
	this(const(char)* cstr, STRINGENCODING type = /*STRINGENCODING.*/STRINGENCODING_XBIT) 	nothrow @nogc
	{
		C4DOS.St.Init(&this);
		C4DOS.St.InitCString(&this, cstr, -1, type);
	}
	//from utf8 string 
	this(ref const string str)
	{
		C4DOS.St.Init(&this);
		C4DOS.St.InitCString(&this, str.ptr, cast(Int32)str.length, STRINGENCODING_UTF8);
		//auto cstr = toStringz(str);
		//C4DOS.St.InitCString(&this, cstr, -1, STRINGENCODING_UTF8);
	}
	this(in string str)
	{
		C4DOS.St.Init(&this);
		C4DOS.St.InitCString(&this, str.ptr, cast(Int32)str.length, STRINGENCODING_UTF8);
		//auto cstr = toStringz(str);
		//C4DOS.St.InitCString(&this, cstr, -1, STRINGENCODING_UTF8);
	}


	/*static String opCall() { //String()
		String n; 
		//C4DOS.S.Init(&n); //? work ???
		return n;
	}*/

	//from utf32 dstring  //SLOW !!!
	this(ref const dstring dstr)
	{
		C4DOS.St.Init(&this);
		wstring temp = toUTF16(dstr);
		C4DOS.St.SetUcBlock(&this, cast(UInt16*)temp.ptr, cast(Int32)temp.length);
	}
	this(in dstring dstr)
	{
		C4DOS.St.Init(&this);
		wstring temp = toUTF16(dstr);
		C4DOS.St.SetUcBlock(&this, cast(UInt16*)temp.ptr, cast(Int32)temp.length);
	}

	this(Int count, UInt16 fillch) 	nothrow @nogc
	{
		C4DOS.St.Init(&this);
		C4DOS.St.InitArray(&this, cast(Int32)(count), fillch);
	}


	// operator +=, ~=
	ref String opOpAssign(string op) (auto ref const String rhs) {
		static if (op == "~") { //~=
			C4DOS.St.Add(&this,&rhs);
			return this;
		} 
		else static if (op == "+") { //+=
			C4DOS.St.Add(&this,&rhs); //Insert(GetLength(), rhs);
			return this;
		}
		else static assert(0, "Operator "~op~" not implemented");
	}
	ref String opOpAssign(string op) (auto ref const string rhs) {
		static if (op == "~") { //~=
			String tmp = (rhs);
			C4DOS.St.Add(&this,&tmp);
			return this;
		} 
		else static if (op == "+") { //+=
			String tmp = (rhs);
			C4DOS.St.Add(&this,&tmp);
			return this;
		}
		else static assert(0, "Operator "~op~" not implemented");
	}


	// operator +, ~
	String opBinary(string op)(auto ref const String rhs) {
		static if (op == "~") { //~
			String s = String(this);
			s += rhs;
			return s;
		} else
		static if (op == "+") { //+
			String s = String(this);
			s += rhs;
			return s;
		}
		else static assert(0, "Operator "~op~" not implemented");
	}
	// operator +, ~
	String opBinary(string op)(auto ref const string rhs) { //TODO
		static if (op == "~") { //~
			String s = String(this);
			s += rhs;
			return s;
		} else
			static if (op == "+") { //+
				String s = String(this);
				s += rhs;
				return s;
			}
			else static assert(0, "Operator "~op~" not implemented");
	}

	// operator ==,  operator !=
	bool opEquals(in String rhs) const  {
		return Compare(rhs) == 0;
	}
	bool opEquals(ref const String rhs) const  {
		return Compare(rhs) == 0;
	}
	bool opEquals(in string rhs) const   {
		//String tmp = rhs;
		//return Compare(tmp) == 0;
		return Compare(String(rhs)) == 0;
	}
	/*bool opEquals(const(char)[] rhs) const  {
		return Compare(String(rhs)) == 0;
	}*/

	// op is one of <, <=, >, or >=
	// A negative value if the left-hand object is considered to be before the right-hand object
	//	A positive value if the left-hand object is considered to be after the right-hand object
	//	Zero if the objects are considered to have the same sort order
	int opCmp(ref const String rhs) const   {
		return Compare(rhs);
	}
	int opCmp(in String rhs) const   {
		return Compare(rhs);
	}

	//-------------------------------------------------------------------------

	void CopyTo(String *str) const	{
		C4DOS.St.CopyTo(&this,str);
	}

	Int32 GetLength() const { return C4DOS.St.GetLength(&this);  }
	Bool Content() const { return GetLength()!=0; }

	// 0 == , <0 < , >0 >
	//Zero if the strings are identical, < 0 if this string is less than cs, or > 0 if this string is greater than cs.
	Int32 Compare()(auto ref const(String) cs) const {	return C4DOS.St.Compare(&this,cs);	}

	Int32 LexCompare(ref const String  cs) const	{	return C4DOS.St.LexCompare(&this,cs);	}

	Int32 RelCompare(ref const String  cs) const	{	return C4DOS.St.RelCompare(&this,cs);	}

	Int32 ComparePart(ref const String  Str, Int cnt, Int pos) const	{
		return C4DOS.St.ComparePart(&this,Str, cast(Int32)(cnt), cast(Int32)(pos));
	}

	Int32 LexComparePart(ref const String  Str, Int cnt, Int pos) const	{
		return C4DOS.St.LexComparePart(&this,Str, cast(Int32)(cnt), cast(Int32)(pos));
	}

	Bool FindFirst()(auto ref const String  cs, Int32* pos, Int start = 0) const	{
		return C4DOS.St.FindFirst(&this,cs, pos, cast(Int32)(start));
	}

	Bool FindLast(ref const String  cs, Int32* pos, Int start = -1) const	{
		return C4DOS.St.FindLast(&this,cs, pos, cast(Int32)(start));
	}

	Bool FindFirst(UInt16 ch, Int32* pos, Int start = 0) const	{
		return C4DOS.St.FindFirstCh(&this,ch, pos, cast(Int32)(start));
	}

	Bool FindLast(UInt16 ch, Int32* pos, Int start = -1) const	{
		return C4DOS.St.FindLastCh(&this,ch, pos, cast(Int32)(start));
	}

	// searches a string case insensitive, "findupper" has to be uppercase!!!
	Bool FindFirstUpper(ref const String  findupper, Int32* pos, Int start) const	{
		return C4DOS.St.FindFirstUpper(&this,findupper, pos, cast(Int32)(start));
	}

	Bool FindLastUpper(ref const String  findupper, Int32* pos, Int start) const	{
		return C4DOS.St.FindLastUpper(&this,findupper, pos, cast(Int32)(start));
	}

	void Delete(Int pos, Int count)	{
		C4DOS.St.Delete(&this,cast(Int32)(pos), cast(Int32)(count));
	}

	void Insert(Int pos, UInt16 ch)	{
		String tmp = String(1, ch);
		C4DOS.St.Insert(&this,cast(Int32)(pos), tmp, -1, -1);
	}

	void Insert(Int pos, ref const String  cs, Int start = -1, Int end = -1)	{
		C4DOS.St.Insert(&this,cast(Int32)(pos), cs, cast(Int32)(start), cast(Int32)(end));
	}

	String SubStr(Int start, Int count) const	{
		return C4DOS.St.SubStr(&this,cast(Int32)(start), cast(Int32)(count));
	}

	String Left(Int count) const { 	return SubStr(0, cast(Int32)(count));	}
	String Right(Int count) const	{	return SubStr(GetLength() - cast(Int32)(count), cast(Int32)(count));	}

	Float ParseToFloat(Int32* error = nullptr, Int unit = 0, Int angletype = 0, Int base = 10) const	{
		return C4DOS.St.ParseToFloat(&this,error, cast(Int32)(unit), cast(Int32)(angletype), cast(Int32)(base));
	}

	Int32 ParseToInt32(Int32* error = nullptr) const	{
		return C4DOS.St.ParseToInt32(&this,error);
	}

	static String MemoryToString(Int64 mem) { return C4DOS.St.MemoryToString(mem); }
	static String HexToString(UInt32 v, Bool prefix0x = true) { return C4DOS.St.HexToString32(v, prefix0x); }
	static String HexToString(UInt64 v, Bool prefix0x = true) { return C4DOS.St.HexToString64(v, prefix0x); }
	static String IntToString(Int32 l) { return C4DOS.St.IntToString64(cast(Int64)l); }
	static String IntToString(Int64 l) { return C4DOS.St.IntToString64(l); }
	static String UIntToString(UInt32 l) { return C4DOS.St.UIntToString64(cast(UInt64)l); }
	static String UIntToString(UInt64 l) { return C4DOS.St.UIntToString64(l); }
	static String FloatToString(Float32 v, Int32 vvk = -1, Int32 nnk = -1, Bool e = false, UInt16 xchar = '0') { return C4DOS.St.FloatToString32(v, vvk, nnk, e, xchar); }
	static String FloatToString(Float64 v, Int32 vvk = -1, Int32 nnk = -1, Bool e = false, UInt16 xchar = '0') { return C4DOS.St.FloatToString64(v, vvk, nnk, e, xchar); }
/*
	static String VectorToString(ref const Vector64  v, Int32 nnk = -1)	{
		return "(" + FloatToString(cast(Float64)v.x, -1, nnk) + ";" + FloatToString(cast(Float64)v.y, -1, nnk) + ";" + FloatToString(cast(Float64)v.z, -1, nnk) + ")";
	}

	static String VectorToString(ref const Vector32  v, Int32 nnk = -1)	{
		return "(" + FloatToString(cast(Float32)v.x, -1, nnk) + ";" + FloatToString(cast(Float32)v.y, -1, nnk) + ";" + FloatToString(cast(Float32)v.z, -1, nnk) + ")";
	}
*/
	Int64 ToInt64(Bool* error = nullptr) const { return C4DOS.St.ToInt64(&this,error); }
	Int32 ToInt32(Bool* error = nullptr) const { return C4DOS.St.ToInt32(&this,error); }
	UInt64 ToUInt64(Bool* error = nullptr) const { return C4DOS.St.ToUInt64(&this,error); }
	UInt32 ToUInt32(Bool* error = nullptr) const { return C4DOS.St.ToUInt32(&this,error); }

	Float ToFloat(Bool* error = nullptr) const { return C4DOS.St.ToFloat(&this,error); }

	Int ToInt(Bool* error = nullptr) const	{
		static if(MAXON_TARGET_64BIT) {
			return ToInt64(error);
		} else {
			return ToInt32(error);
		}
	}

	UInt ToUInt(Bool* error = nullptr) const	{
		static if(MAXON_TARGET_64BIT) {
			return ToUInt64(error);
		} else {
			return ToUInt32(error);
		}
	}

	String ToUpper() const {	return C4DOS.St.ToUpper(&this,);	}

	String ToLower() const	{	return C4DOS.St.ToLower(&this,);	}

	Int32 GetCStringLen(STRINGENCODING type = STRINGENCODING_XBIT) const	{
		return C4DOS.St.GetCStringLen(&this,type);
	}

	Int32 GetCString(Char* scstr, Int max, STRINGENCODING type = STRINGENCODING_XBIT) const	{
		return C4DOS.St.GetCString(&this,scstr, cast(Int32)(max), type);
	}

	Char* GetCStringCopy(STRINGENCODING type = STRINGENCODING_XBIT) const{
		Int32 len = C4DOS.St.GetCStringLen(&this,type);
		if (!len) return null;

		Char* txt = GeAllocType!Char(len+2); //NewMemClear(Char, len + 2);
		if (!txt) return null;

		C4DOS.St.GetCString(&this,txt, len + 2, type);
		txt[len] = 0;
		return txt;
	}

	void SetCString(const Char* cstr, Int count = -1, STRINGENCODING type = STRINGENCODING_XBIT)	{
		C4DOS.St.InitCString(&this, cstr, cast(Int32)(count), type);
	}

	Int32 SetCStringR(const Char* cstr, Int count = -1, STRINGENCODING type = STRINGENCODING_XBIT)	{
		C4DOS.St.InitCString(&this, cstr, cast(Int32)(count), type);
		return GetLength();
	}

	void GetUcBlock(UInt16* Ubc, Int maxSize) const	{
		C4DOS.St.GetUcBlock(&this,Ubc, cast(Int32)(maxSize));
	}

	void GetUcBlockNull(UInt16* Ubc, Int maxSize) const	{
		C4DOS.St.GetUcBlockNull(&this,Ubc, cast(Int32)(maxSize));
	}

	void SetUcBlock(const UInt16* Ubc, Int count)	{
		C4DOS.St.SetUcBlock(&this,Ubc, cast(Int32)(count));
	}

	UInt16 GetChr(const UInt32 Pos) const { return C4DOS.St.GetChr(&this,Pos); }
	void   SetChr(const UInt32 Pos, UInt16 c) { C4DOS.St.SetChr(&this,Pos,c); }

	/// operator []
	void opIndexAssign(UInt16 value, UInt32 Pos){
		if(Pos<GetLength()) C4DOS.St.SetChr(&this,Pos,value);
	}

	const(UInt16) opIndex(UInt32 Pos) const	{
		return (Pos<GetLength()) ? C4DOS.St.GetChr(&this,Pos) : 0;
	}

	//! The caller owns the pointed array.
	// AutoGeFree<UInt16> Ubc = str.GetDataPtrCopy();
	// do work with Ubc...
	// str.SetUcBlock(Ubc,str.GetLength());
	UInt16* GetDataPtrCopy() const { 
		const Int32 len = GetLength();
		if (!len) return null;
		UInt16 *Ubc = NewMemClear!(UInt16)(len + 2);
		if (!Ubc) return null;
		GetUcBlockNull(Ubc,len + 2);
		return Ubc;
	}

}; //String
static assert(String.sizeof==24,"sizeof String is not 24 bytes !");
//pragma(msg, struct_diagram!String);

//----------------------------------------------------------------------------------------------------------------
unittest
{
	import std.conv;
	//import c4d_general : GePrint;
	if(C4DOS) {
		/*
		{
			String s = "AAAA";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s.ptr,s.m_size, s.m_len, s.m_txt,s.m_future_enhancements);

			String s0 = "AAAA";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s0.ptr,s0.m_size, s0.m_len, s0.m_txt,s0.m_future_enhancements);

			String s1 = "AAAA";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s1.ptr,s1.m_size, s1.m_len, s1.m_txt,s1.m_future_enhancements);
			s1 += "BBB";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s1.ptr,s1.m_size, s1.m_len, s1.m_txt,s1.m_future_enhancements);
		}
		{
			String s = "123456789";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s.ptr,s.m_size, s.m_len, s.m_txt,s.m_future_enhancements);

			String s0 = "123456789123456789";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s0.ptr,s0.m_size, s0.m_len, s0.m_txt,s0.m_future_enhancements);

			String s1 = "123456789123456789123456789 123456789123456789123456789123456789123456789123456789";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s1.ptr,s1.m_size, s1.m_len, s1.m_txt,s1.m_future_enhancements);
			s1 += "123456789";
			printf("### %p size: %x, len: %x, ptr: %p, fut: %p \n",s1.ptr,s1.m_size, s1.m_len, s1.m_txt,s1.m_future_enhancements);
		}
		*/

		String s1 = "12345";
		assert(s1.GetLength()==5);
		assert(s1=="12345");
		{
			String copy = s1;
			assert(s1==copy);
		}
		assert(s1=="12345");

		s1 ~= ("c");
		assert(s1=="12345c");
		s1 += ("d");
		assert(s1=="12345cd");
		assert(s1.GetLength()==7);

		String s2 = s1 + s1;
		assert(s2.GetLength()==14);
		assert(s2=="12345cd12345cd");

		String s3 = s1 ~ s1;
		assert(s3.GetLength()==14,to!string(s3.GetLength())/*.stringof*/);
		assert(s3=="12345cd12345cd");

		//printf("test \n");
		//assert(false,"test assert !! ");

		void test_fn1(in String str){
		}
		String s = "ree";
		//string ds = s;
		//test_fn1("test");
	}
}


/+

#define USE_EX_STRING 1 ///OK

//=================================================================================================
class String
{
#if USE_EX_STRING
	#define StCall(fnc, ...) C4DOS.St->fnc(this,##__VA_ARGS__)
#else
	//#define StCall(fnc) (this->*C4DOS.St->fnc) //default
#endif

	private:
#ifndef USE_EX_STRING
		C4D_RESERVE_PRIVATE_TYPE(LONG,dummy1);
		C4D_RESERVE_PRIVATE_TYPE(LONG,dummy2);
		C4D_RESERVE_PRIVATE_TYPE(void*,dummy3);
		C4D_RESERVE_PRIVATE_TYPE(void*,dummy4);
#else
		LONG	m_size; 	// actual allocated size / capacity() //min 16
		LONG	m_len; 		// number of characters / size()
		UWORD*	m_txt; 		// data
		void*	m_future_enhancements;
#endif

public:
		void CopyTo(String *str) const
		{
			C4DOS.St->CopyTo(this,str);
		}

		const String& operator = (const String &cs)
		{
			C4DOS.St->CopyTo(&cs,this);
			return *this;
		}

		String(void) 
			: m_size(0),m_len(0),m_txt(0),m_future_enhancements(0)
		{
			C4DOS.St->Init(this);
		}

		String(const String &cs)
		{
			C4DOS.St->Init(this);
			C4DOS.St->CopyTo(&cs,this);
		}

		String(const UWORD* s)
		{
			C4DOS.St->Init(this);
			StCall(SetUcBlock, s, -1);
		}

		String(const CHAR *cstr,STRINGENCODING type=STRINGENCODING_XBIT)
			 : m_size(0),m_len(0),m_txt(0),m_future_enhancements(0)
		{
			C4DOS.St->Init(this);
			C4DOS.St->InitCString(this,cstr,-1,type);
		}

		String(LONG count,UWORD fillch)
		{
			C4DOS.St->Init(this);
			C4DOS.St->InitArray(this,count,fillch);
		}

		~String(void)
		{
			C4DOS.St->Flush(this);
		}
#if USE_EX_STRING
		LONG GetLength() const { return m_len; }
#else
		LONG GetLength() const
		{
			return StCall(GetLength);
		}
#endif
		Bool Content() const { return GetLength()!=0; }

		friend const String operator + (const String &Str1,const String &Str2)
		{
			String s(Str1);
			s += Str2;
			return s;
		}

		const String& operator += (const String &Str)
		{
			Insert(GetLength(),Str);
			return *this;
		}

		Bool operator < (const String &Str) const
		{
			return (Compare(Str) < 0);
		}

		Bool operator > (const String &Str) const
		{
			return (Compare(Str) > 0);
		}

		Bool operator <= (const String &Str) const
		{
			return (Compare(Str) <= 0);
		}

		Bool operator >= (const String &Str) const
		{
			return (Compare(Str) >= 0);
		}

		Bool operator == (const String &Str) const
		{
			return (Compare(Str) == 0);
		}

		Bool operator != (const String &Str) const
		{
			return (Compare(Str) != 0);
		}

		// 0 == , <0 < , >0 >
		LONG Compare(const String &cs) const
		{
			return StCall(Compare, cs);
		}

		LONG LexCompare(const String &cs) const
		{
			return StCall(LexCompare, cs);
		}

		LONG RelCompare(const String &cs) const
		{
			return StCall(RelCompare, cs);
		}

		LONG ComparePart(const String &Str, LONG cnt, LONG pos) const
		{
			return StCall(ComparePart, Str,cnt,pos);
		}

		LONG LexComparePart(const String &Str, LONG cnt, LONG pos) const
		{
			return StCall(LexComparePart, Str,cnt,pos);
		}

		Bool FindFirst(const String &cs,LONG *pos,LONG start=0) const
		{
			return StCall(FindFirst, cs,pos,start);
		}

		Bool FindLast(const String &cs,LONG *pos,LONG start=-1) const
		{
			return StCall(FindLast, cs,pos,start);
		}

		Bool FindFirst(UWORD ch,LONG *pos,LONG start=0) const
		{
			return StCall(FindFirstCh, ch,pos,start);
		}

		Bool FindLast(UWORD ch,LONG *pos,LONG start=-1) const
		{
			return StCall(FindLastCh, ch,pos,start);
		}

		// searches a string case insensitive, "findupper" has to be uppercase!!!
		Bool FindFirstUpper(const String &findupper, LONG *pos, LONG start) const
		{
			return StCall(FindFirstUpper, findupper,pos,start);
		}

		Bool FindLastUpper(const String &findupper, LONG *pos, LONG start) const
		{
			return StCall(FindLastUpper, findupper,pos,start);
		}

		void Delete(LONG pos,LONG count)
		{
			StCall(Delete, pos,count);
		}

		void Insert(LONG pos,UWORD ch)
		{
			String tmp = String(1,ch);
			StCall(Insert, pos,tmp,-1,-1);
		}

		void Insert(LONG pos,const String &cs,LONG start=-1, LONG end=-1)
		{
			StCall(Insert, pos,cs,start,end);
		}

		String SubStr(LONG start,LONG count) const
		{
			return StCall(SubStr, start,count);
		}

		String Left(LONG count) const
		{
			return SubStr(0, count);
		}

		String Right(LONG count) const
		{
			return SubStr(GetLength() - count, count);
		}

		Real ToReal(LONG *error=NULL, LONG unit=0, LONG angletype=0, LONG base=10) const
		{
			return StCall(ToReal, error,unit,angletype,base);
		}

		LONG ToLong(LONG *error=NULL) const
		{
			return StCall(ToLong, error);
		}

		friend String RealToString(Real v, LONG vk, LONG nk, Bool e, UWORD xchar);
		friend String LongToString(LONG l);
		friend String LLongToString(LLONG l);
			
		String ToUpper() const
		{
			return StCall(ToUpper);
		}

		String ToLower() const
		{
			return StCall(ToLower);
		}
		
		LONG GetCStringLen(STRINGENCODING type=STRINGENCODING_XBIT) const
		{
			return StCall(GetCStringLen, type);
		}

		LONG GetCString(CHAR *scstr, LONG max, STRINGENCODING type=STRINGENCODING_XBIT) const
		{
			return StCall(GetCString, scstr,max,type);
		}

		CHAR *GetCStringCopy(STRINGENCODING Type=STRINGENCODING_XBIT) const;
		
		void SetCString(const CHAR *cstr, LONG count=-1, STRINGENCODING type=STRINGENCODING_XBIT)
		{
			C4DOS.St->InitCString(this, cstr, count, type);
		}

		LONG SetCStringR(const CHAR *cstr, LONG count=-1, STRINGENCODING type=STRINGENCODING_XBIT)
		{
			C4DOS.St->InitCString(this, cstr, count, type);
			return GetLength();
		}

		void GetUcBlock(UWORD *Ubc, LONG Max) const
		{
			StCall(GetUcBlock, Ubc,Max);
		}

		void GetUcBlockNull(UWORD *Ubc, LONG Max) const
		{
			StCall(GetUcBlockNull, Ubc,Max);
		}

		void SetUcBlock(const UWORD *Ubc, LONG Count)
		{
			StCall(SetUcBlock, Ubc,Count);
		}

		class PChar
		{
			friend class String;
			
			private:
				String *Str;
				LONG Pos;

				PChar(String *str,LONG pos)
				{
					Str = str;
					Pos = pos;
				}
				
			public:
				PChar& operator = (const PChar& rhs)
				{
					C4DOS.St->SetChr(Str,Pos,C4DOS.St->GetChr(rhs.Str,rhs.Pos));
					return *this;
				}

				PChar& operator = (UWORD c)
				{
					C4DOS.St->SetChr(Str,Pos,c);
					return *this;
				}

				operator UWORD(void) const
				{
					return C4DOS.St->GetChr(Str,Pos);
				}
		};
		
		const PChar operator[] (LONG Pos) const
		{
			return PChar((String*)this,Pos);
		}

		PChar operator[] (LONG Pos)
		{
			return PChar((String*)this,Pos);
		}

#ifdef USE_EX_STRING //------------------------------------------------------

		String(String&& other);		// Move constructor
		String& operator=(String&& other);	// Move assignment operator.
		void MoveTo(String *str);

		//const UWORD operator() (LONG Pos) const	{	return C4DOS.St->GetChr(this,Pos);	}
		const UWORD operator() (LONG Pos) const	{  if(Pos >=0 && Pos<m_len) return m_txt[Pos]; else return 0;	}

		UWORD GetChr(LONG Pos) { return C4DOS.St->GetChr(this,Pos); }
		void  SetChr(LONG Pos, UWORD c) { C4DOS.St->SetChr(this,Pos,c); }


		void Append(const String &str){	Insert(GetLength(),str); }

		// Move + operator.
		friend String operator+ (String &&str1, String &&str2) {
			if (str2.size() <= str1.capacity() - str1.size()
				|| str2.capacity() - str2.size() <  str1.size()){
					str1.Insert(str1.GetLength(),str2); //Append();
					return (String&&)(str1);
			}else{
				str2.Insert(0,str1);
				return (String&&)(str2);
			}
		}
		friend String operator+ (const String &str1, String &&str2) {
			str2.Insert(0,str1);
			return (String&&)(str2); //std::forward<String>(str2);
		}
		friend String operator+ (String &&str1, const String &str2) {
			str1.Insert(str1.GetLength(),str2); //Append();
			return (String&&)(str1); //std::forward<String>(str1);
		}


		const String& operator += ( UWORD ch )	{ //UWORD support
			Insert(GetLength(),ch);
			return *this;
		}
		const String& operator += ( CHAR ch )	{ //CHAR support
			Insert(GetLength(),(UWORD)ch);
			return *this;
		}

		///std mimicry 
		LONG	capacity() const { return m_size; } 		// actual allocated size
		LONG	GetSize() const { return m_size; } 		// actual allocated size //remove this 
		LONG	GetCapacity() const { return m_size; } // actual allocated size

		LONG	size() const { return m_len; }	 	// number of characters
		LONG	GetLen() const { return m_len; }	 	// number of characters

		bool empty() const { return m_len==0; } //checks whether the container is empty 

		void push_back( UWORD ch ) { Insert(GetLength(),ch); }
		void push_back( const String& cs ) { Insert(GetLength(),cs); }

		LONG insert( ULONG pos, UWORD ch ) { Insert(pos,ch); return pos; }
		LONG insert( ULONG pos, const String& cs ) { Insert(pos,cs); return pos; }

		void clear() {	C4DOS.St->Flush(this);	} // Free the existing resource.
		LONG erase( ULONG pos ) { //Removes the element at pos. 
			ULONG len(GetLength()); 
			if(pos<len) Delete(pos,1);
			return pos; 
		} 
		LONG erase( ULONG first,ULONG last ) { //Removes the elements in the range [first; last). 
			ULONG len(GetLength()); 
			if(last<len && first<last) Delete(first,last-first); 
			return first; 
		}

		//const UWORD* GetRawData() const { return m_txt; } 		// data
		//use like this  // const LONG  len = str.GetDataPtr(&raw);
		inline LONG GetDataPtr(const UWORD **out_ptr) const {  *out_ptr = m_txt; return m_len;	}


		// initialization of the string
		void Init(LONG Count = 0, UWORD FillCh = 0)	{ C4DOS.St->InitArray(this,Count,FillCh); }
		void Construct(void)	{  C4DOS.St->Init(this); 	}

		//void ShrinkToLen();// optimizes the memory usage after delete, init etc...

		void Free() {	C4DOS.St->Flush(this);	} // Free the existing resource.
#else 
		void Free() {	C4DOS.St->Flush(this);	} // Free the existing resource.
#endif	//---------------------------------------------------------------------
};

#ifdef USE_EX_STRING // ------------------------------------------------------

// Move constructor
inline String::String(String&& other)	{
	///C4DOS.St->Init(this); //do we need this ?
	// Copy the data pointer and its length from the source object.
	m_len = other.m_len;	other.m_len = 0;
	m_size = other.m_size;	other.m_size = 0;
	m_txt = other.m_txt;	other.m_txt = NULL;
	m_future_enhancements = other.m_future_enhancements;
	other.m_future_enhancements = NULL;
}

// Move assignment operator.
inline String& String::operator=(String&& other) {
	if (this != &other) {
		C4DOS.St->Flush(this);// Free the existing resource.
		// Copy the data pointer and its length from the source object.
		m_len = other.m_len;	other.m_len = 0;
		m_size = other.m_size;	other.m_size = 0;
		m_txt = other.m_txt;	other.m_txt = NULL;
		m_future_enhancements = other.m_future_enhancements;		
		other.m_future_enhancements = NULL;
	}
	return *this;
}

inline void String::MoveTo(String *str) {
	if(str!=NULL && this != str) {
		C4DOS.St->Flush(str);

		str->m_len = m_len;		m_len = 0;
		str->m_size = m_size;	m_size = 0;
		str->m_txt = m_txt;		m_txt = NULL;
		str->m_future_enhancements = m_future_enhancements;
		m_future_enhancements = NULL;
	}
}
#endif //---------------------------------------------------------------------


inline String LongToString(LONG l) { return C4DOS.St->LongToString(l); }
inline String LLongToString(LLONG l) { return C4DOS.St->LLongToString(l); }
inline String RealToString(Real v, LONG vvk=-1, LONG nnk=-1, Bool e=FALSE, UWORD xchar='0') { return C4DOS.St->RealToString(v,vvk,nnk,e,xchar); }

String PtrToString(const void *hex);
String MemoryToString(LLONG mem);

#define TString(x) String(x) // use TString to mark strings to translate

+/
