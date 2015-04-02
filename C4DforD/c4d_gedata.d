
module c4d_gedata;

import c4d;
import c4d_os;

enum DA
{
	DA_NIL				= 0,
	DA_VOID				= 14,
	DA_LONG				= 15,
	DA_REAL				= 19,
	DA_TIME				= 22,
	DA_VECTOR			= 23,
	DA_MATRIX			= 25,
	DA_LLONG			= 26,
	DA_BYTEARRAY		= 128,	// mainly for quicktime
	DA_STRING			= 130,
	DA_FILENAME			= 131,
	DA_CONTAINER		= 132,	// BaseContainer
	DA_ALIASLINK		= 133,	// for alias links -> new in 7300
	DA_MARKER			= 256,
	DA_MISSINGPLUG		= 257,	// missing datatype plugin

	DA_CUSTOMDATATYPE   = 1000000,	// DataTypes > 1000000 are custom

	DA_END
}
mixin ENUM_END_FLAGS!(DA);

enum DEFAULTVALUETYPE
{
	DEFAULTVALUE
} mixin ENUM_END_FLAGS!(DEFAULTVALUETYPE);

enum VOIDVALUETYPE
{
	VOIDVALUE
} mixin ENUM_END_FLAGS!(VOIDVALUETYPE);

enum LLONGVALUETYPE
{
	LLONGVALUE
} mixin ENUM_END_FLAGS!(LLONGVALUETYPE);


//=============================================================================
struct GeData
{
//nothrow:
@nogc:

private:
	Int32	Type = DA_NIL;
	Int32	dummy;	// necessary for Linux alignment of structure

	union
	{
		Int32	DInteger = 0;
		Float	DReal;
		void*	Ddata;
		Int64	DLLong;
	};

public:
	// constructors
	/*this() {
		Type = DA_NIL;
		DInteger = 0;
	}*/

	this(this){ //copy constructor >>>
		GeData tmp;
		MemCopy(&tmp,&this,GeData.sizeof);

		Type  = DA_NIL;  //important 
		Ddata = null;
		C4DOS.Gd.CopyData(&this, &tmp, null);

		tmp.Type = DA_NIL;
		tmp.DInteger = 0;
	}

	this(double n)	{
		Type  = DA_REAL;
		DReal = cast(Float)n;
	}

	this(ref const GeData  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.CopyData(&this, &n, nullptr);
	}

	this(Int32 n) {
		Type = DA_LONG;
		DInteger = n;
	}

	this(Float32 n) {
		Type	= DA_REAL;
		DReal = n;
	}

	this(void * v, VOIDVALUETYPE xdummy) {
		Type	= DA_VOID;
		Ddata = v;
	}

	this(Int64 v, LLONGVALUETYPE xdummy) {
		Type = DA_LLONG;
		DLLong = v;
	}

	this(ref const Vector  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetVector(&this, n);
	}

	/*this(ref const C4DUuid  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetUuid(&this, &n);
	}*/

	this(ref const Matrix  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetMatrix(&this, n);
	}

	this(const Char* n) {
		String str = String(n);
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetString(&this, &str);
	}

	this(ref const String  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetString(&this, &n);
	}

	this(void * mem, Int count) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetMemory(&this, mem, count);
	}

	this(ref const Filename  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetFilename(&this, &n);
	}

	this(ref const BaseTime  n)	{
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetBaseTime(&this, n);
	}

	this(ref const BaseContainer  n) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetBaseContainer(&this, &n);
	}

	this(const BaseLink* n)	{
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetLink(&this, *n);
	}

	this(BaseList2D* bl) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetBlLink(&this, bl);
	}

	this(Int32 type, ref const CustomDataType  data) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.SetCustomData(&this, type, data);
	}

	this(Int32 type, DEFAULTVALUETYPE v) {
		Type	= DA_NIL;
		Ddata = nullptr;
		C4DOS.Gd.InitCustomData(&this, type);
	}

	Bool SetDefault(Int32 type)	{
		return C4DOS.Gd.InitCustomData(&this, type);
	}

	// destructor
	void Free()	{
		C4DOS.Gd.Free(&this);
	}

	~this()	{
		C4DOS.Gd.Free(&this);
	}

	// operators
	/+
	ref const GeData  operator = (ref const GeData  n){
		n.CopyData(&this, nullptr);
		return *this;
	}

	Bool operator == (ref const GeData  d) const {
		return C4DOS.Gd.IsEqual(&this, &d);
	}

	Bool operator != (ref const GeData  d) const {
		return !C4DOS.Gd.IsEqual(&this, &d);
	}
	+/
	// operator ==,  operator !=
	bool opEquals(ref const GeData d) const  {
		return cast(bool) C4DOS.Gd.IsEqual(&this, &d);
	}
	// operator ==,  operator !=
	bool opEquals(in GeData d) const  {
		return cast(bool) C4DOS.Gd.IsEqual(&this, &d);
	}

	// operator =  !TODO
	/*ref const GeData opAssign(ref const GeData n){
		n.CopyData(&this, nullptr);
		return *this;
	}*/


	Int32 GetType() const {
		return C4DOS.Gd.GetType(&this);
	}

	// take care: the results are only valid as long as the GeData value exists
	Bool                    GetBool     () const { return C4DOS.Gd.GetInt32(&this) != 0; }
	Int32	                GetInt32    () const { return C4DOS.Gd.GetInt32(&this); }
	Int64	                GetInt64    () const { return C4DOS.Gd.GetInt64(&this); }
	Float	                GetFloat    () const { return C4DOS.Gd.GetFloat(&this); }
	void *		            GetVoid		() const { return C4DOS.Gd.GetCustomData(&this, DA_VOID);	}
	ref Vector 		GetVector   () const { return  C4DOS.Gd.GetVector(&this); } //ref problem
	ref Matrix 		GetMatrix   () const { return  C4DOS.Gd.GetMatrix(&this); } //ref problem
	ref String 		GetString   () const { return  C4DOS.Gd.GetString(&this); } //ref problem
	//ref const C4DUuid 	GetUuid     () const { return  C4DOS.Gd.GetUuid(&this); } //ref problem
	ref Filename 	    GetFilename () const { return  C4DOS.Gd.GetFilename(&this); } //ref problem
	ref BaseTime 	    GetTime     () const { return  C4DOS.Gd.GetTime(&this); } //ref problem
	BaseContainer*			GetContainer() const { return C4DOS.Gd.GetContainer(&this); }
	BaseLink*				GetBaseLink () const { return C4DOS.Gd.GetLink(&this); }
	CustomDataType*			GetCustomDataType(Int32 datatype) const { return C4DOS.Gd.GetCustomData(&this, datatype); }
	BaseList2D*				GetLink(const BaseDocument* doc, Int32 instanceof = 0) const;
	C4DAtomGoal*			GetLinkAtom(const BaseDocument* doc, Int32 instanceof = 0) const;
	void *					GetMemoryAndRelease	(ref Int  count)	{	return C4DOS.Gd.GetMemoryAndRelease(&this, count); }
	void *					GetMemory(ref Int  count)	{	return C4DOS.Gd.GetMemory(&this, count); }

	void CopyData(GeData* dest, AliasTrans* aliastrans) const	{
		C4DOS.Gd.CopyData(dest, &this, aliastrans);
	}

	void SetFloat	 (Float v) { C4DOS.Gd.SetFloat(&this, v);	}
	void SetInt32	 (Int32 v) { C4DOS.Gd.SetInt32(&this, v);	}
	void SetInt64	 (ref const Int64  v)	 { C4DOS.Gd.SetInt64(&this, v);	}
	void SetVoid	 (void * v) { C4DOS.Gd.SetVoid(&this, v); }
	void SetMemory	 (void * data, Int count) { C4DOS.Gd.SetMemory(&this, data, count); }

	void SetVector	 (ref const Vector  v) { C4DOS.Gd.SetVector(&this, v); }
	void SetVector	 (in Vector  v) { C4DOS.Gd.SetVector(&this, v); }

	void SetMatrix	 (ref const Matrix  v) { C4DOS.Gd.SetMatrix(&this, v); }
	void SetMatrix	 (in Matrix  v) { C4DOS.Gd.SetMatrix(&this, v); }

	void SetString	 (ref const String  v) { C4DOS.Gd.SetString(&this, &v);	}
	void SetString	 (in String  v) { C4DOS.Gd.SetString(&this, &v);	}

	//? void SetUuid	 (ref const C4DUuid  v)	 { C4DOS.Gd.SetUuid(&this, &v);	}
	void SetFilename (ref const Filename  v) { C4DOS.Gd.SetFilename(&this, &v);	}
	void SetBaseTime (ref const BaseTime  v) { C4DOS.Gd.SetBaseTime(&this, v); }
	void SetContainer(ref const BaseContainer  v)	 { C4DOS.Gd.SetBaseContainer(&this, &v); }
	//? void SetBaseLink (ref const BaseLink  v) { C4DOS.Gd.SetLink(&this, v); }
	void SetBaseList2D(BaseList2D* bl)	 { C4DOS.Gd.SetBlLink(&this, bl);	}
	void SetCustomDataType(Int32 datatype, ref const CustomDataType  v)	 { C4DOS.Gd.SetCustomData(&this, datatype, v); }
};

static assert(GeData.sizeof==16,"sizeof GeData is not 16 bytes !");


unittest
{
if(C4DOS) {

	GeData gd;
	assert(gd.GetType() == DA_NIL);

	const String st = "test";
	gd.SetString(st);
	{
		GeData copy = gd;
		assert(gd==copy);
		assert(copy.GetString()==st);
	}
	assert(gd.GetString()==st);


	gd.SetVector(Vector(4,5,6));
	assert(gd.GetVector()==Vector(4,5,6));

}//if(C4DOS)
}

/+
class C4DAtomGoal;
class BaseContainer;
class BaseTime;
class String;
class Filename;
class AliasTrans;
class BaseLink;
class BaseList2D;
class BaseDocument;
struct CustomDataType;

enum DA
{
DA_NIL						= 0,
DA_VOID						= 14,
DA_LONG						= 15,
DA_REAL						= 19,
DA_TIME						= 22,
DA_VECTOR					= 23,
DA_MATRIX					= 25,
DA_LLONG					= 26,
DA_BYTEARRAY			= 128,	// mainly for quicktime
DA_STRING					= 130,
DA_FILENAME				= 131,
DA_CONTAINER			= 132,			// BaseContainer
DA_ALIASLINK			= 133,			// for alias links -> new in 7300
DA_MARKER					= 256,
DA_MISSINGPLUG		= 257,			// missing datatype plugin

DA_CUSTOMDATATYPE = 1000000,	// DataTypes > 1000000 are custom

DA_END
};

enum DEFAULTVALUETYPE
{
DEFAULTVALUE
};

enum VOIDVALUETYPE
{
VOIDVALUE
};

enum LLONGVALUETYPE
{
LLONGVALUE
};

class GeData
{
private:
Int32	Type;
Int32	dummy;	// necessary for Linux alignment of structure

union
{
Int32	DInteger;
Float	DReal;
void*	Ddata;
Int64	DLLong;
};

public:
// constructors
GeData(void)
{
Type = DA_NIL;
DInteger = 0;
}

GeData(double n)
{
Type	= DA_REAL;
DReal = (Float)n;
}

GeData(const GeData& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->CopyData(&this, &n, nullptr);
}

GeData(Int32 n)
{
Type = DA_LONG;
DInteger = n;
}

GeData(Float32 n)
{
Type	= DA_REAL;
DReal = n;
}

GeData(void* v, VOIDVALUETYPE xdummy)
{
Type	= DA_VOID;
Ddata = v;
}

GeData(Int64 v, LLONGVALUETYPE xdummy)
{
Type = DA_LLONG;
DLLong = v;
}

GeData(const Vector& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetVector(&this, n);
}

GeData(const C4DUuid& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetUuid(&this, &n);
}

GeData(const Matrix& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetMatrix(&this, n);
}

GeData(const Char* n)
{
String str(n);
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetString(&this, &str);
}

GeData(const String& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetString(&this, &n);
}

GeData(void* mem, Int count)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetMemory(&this, mem, count);
}

GeData(const Filename& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetFilename(&this, &n);
}

GeData(const BaseTime& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetBaseTime(&this, n);
}

GeData(const BaseContainer& n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetBaseContainer(&this, &n);
}

GeData(const BaseLink* n)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetLink(&this, *n);
}

GeData(BaseList2D* bl)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetBlLink(&this, bl);
}

GeData(Int32 type, const CustomDataType& data)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->SetCustomData(&this, type, data);
}

GeData(Int32 type, DEFAULTVALUETYPE v)
{
Type	= DA_NIL;
Ddata = nullptr;
C4DOS.Gd->InitCustomData(&this, type);
}

Bool SetDefault(Int32 type)
{
return C4DOS.Gd->InitCustomData(&this, type);
}

// destructor

void Free(void)
{
C4DOS.Gd->Free(&this);
}

~GeData(void)
{
C4DOS.Gd->Free(&this);
}

// operators
const GeData& operator = (const GeData& n)
{
n.CopyData(&this, nullptr);
return *this;
}

Bool operator == (const GeData& d) const
{
return C4DOS.Gd->IsEqual(&this, &d);
}

Bool operator != (const GeData& d) const
{
return !C4DOS.Gd->IsEqual(&this, &d);
}

Int32 GetType(void) const
{
return C4DOS.Gd->GetType(&this);
}

// take care: the results are only valid as long as the GeData value exists
Bool GetBool     (void) const	{ return C4DOS.Gd->GetInt32(&this) != 0; }
Int32	GetInt32     (void) const	{ return C4DOS.Gd->GetInt32(&this); }
Int64	GetInt64    (void) const { return C4DOS.Gd->GetInt64(&this); }
Float	GetFloat     (void) const	{	return C4DOS.Gd->GetFloat(&this); }
void*								GetVoid			(void) const { return C4DOS.Gd->GetCustomData(&this, DA_VOID);	}
const Vector&		GetVector   (void) const { return C4DOS.Gd->GetVector(&this); }
const Matrix&		GetMatrix   (void) const { return C4DOS.Gd->GetMatrix(&this); }
const String&		GetString   (void) const { return C4DOS.Gd->GetString(&this); }
const C4DUuid&	GetUuid     (void) const { return C4DOS.Gd->GetUuid(&this); }
const Filename&	GetFilename (void) const { return C4DOS.Gd->GetFilename(&this); }
const BaseTime&	GetTime     (void) const { return C4DOS.Gd->GetTime(&this); }
BaseContainer*			GetContainer(void) const { return C4DOS.Gd->GetContainer(&this); }
BaseLink*						GetBaseLink (void) const { return C4DOS.Gd->GetLink(&this); }
CustomDataType*			GetCustomDataType	(Int32 datatype) const { return C4DOS.Gd->GetCustomData(&this, datatype); }
BaseList2D*					GetLink(const BaseDocument* doc, Int32 instanceof = 0) const;
C4DAtomGoal*				GetLinkAtom(const BaseDocument* doc, Int32 instanceof = 0) const;
void*								GetMemoryAndRelease	(Int& count)	{	return C4DOS.Gd->GetMemoryAndRelease(&this, count); }
void*								GetMemory		(Int& count)	{	return C4DOS.Gd->GetMemory(&this, count); }

void CopyData(GeData* dest, AliasTrans* aliastrans) const
{
C4DOS.Gd->CopyData(dest, this, aliastrans);
}

void SetFloat			 (Float v) { C4DOS.Gd->SetFloat(&this, v);	}
void SetInt32			 (Int32 v) { C4DOS.Gd->SetInt32(&this, v);	}
void SetInt64		 (const Int64& v)	 { C4DOS.Gd->SetInt64(&this, v);	}
void SetVoid		 (void* v) { C4DOS.Gd->SetVoid(&this, v); }
void SetMemory	 (void* data, Int count) { C4DOS.Gd->SetMemory(&this, data, count); }
void SetVector	 (const Vector& v) { C4DOS.Gd->SetVector(&this, v); }
void SetMatrix	 (const Matrix& v) { C4DOS.Gd->SetMatrix(&this, v); }
void SetString	 (const String& v) { C4DOS.Gd->SetString(&this, &v);	}
void SetUuid		 (const C4DUuid& v)	 { C4DOS.Gd->SetUuid(&this, &v);	}
void SetFilename (const Filename& v) { C4DOS.Gd->SetFilename(&this, &v);	}
void SetBaseTime (const BaseTime& v) { C4DOS.Gd->SetBaseTime(&this, v); }
void SetContainer(const BaseContainer& v)	 { C4DOS.Gd->SetBaseContainer(&this, &v); }
void SetBaseLink (const BaseLink& v) { C4DOS.Gd->SetLink(&this, v); }
void SetBaseList2D (BaseList2D* bl)	 { C4DOS.Gd->SetBlLink(&this, bl);	}
void SetCustomDataType(Int32 datatype, const CustomDataType& v)	 { C4DOS.Gd->SetCustomData(&this, datatype, v); }
};

class BrowseContainer
{
private:
BaseContainer* t_bc;
void*					 handle;

public:
BrowseContainer(const BaseContainer* bc);
void Reset(void);
Bool GetNext(Int32* id, GeData** data);
};

#endif // C4D_GEDATA_H__

+/