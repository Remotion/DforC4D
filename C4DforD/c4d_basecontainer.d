
module c4d_basecontainer;

import c4d;
import c4d_os;

import lib_description : DescID;
/+
struct DescID //: public iCustomDataType<DescID> // iCustomDataType is okay here since the size is the same
{
private:
	Int32 temp1;
	Int32 *temp2;

public:
	/*
	DescID();
	DescID(const DescID &src);
	DescID(Int32 id1);
	DescID(const DescLevel &id1);
	DescID(const DescLevel &id1, const DescLevel &id2);
	DescID(const DescLevel &id1, const DescLevel &id2, const DescLevel &id3);
	~DescID();

	void SetId(const DescLevel &subid);
	void PushId(const DescLevel &subid);
	void PopId();
	const DescLevel &operator[] (Int32 pos) const;
	const DescID& operator = (const DescID &id);
	Bool operator == (const DescID &d) const;
	Bool operator != (const DescID &d) const;
	const DescID operator <<(Int32 shift) const;

	Bool Read(HyperFile *hf);
	Bool Write(HyperFile *hf);

	Int32 GetDepth() const;
	Bool IsPartOf(const DescID &cmp, Int32 *pos) const;

	const DescID & operator += (const DescID &s);
	friend const DescID operator + (const DescID &v1, const DescID &v2);
	*/
};
+/

//=============================================================================
//extern (C++)
struct BaseContainer
{
private:
//public:
	void*		dummy1 = null; //First
	Int			dummy2 = 0;    //3 ?
	Int32		dummy3 = NOTOK; //id
	Int32		dummy4 = 0; //dirty_sum
	Int32		dummy5 = 0; //dirty_last

public:
	//? @disable this();
	//this(){ C4DOS.Bc.SDKInit(&this,NOTOK, null); }

	//? @disable this(this);
	this(this) {
		BaseContainer tmp;
		MemCopy(&tmp,&this,BaseContainer.sizeof);

		C4DOS.Bc.SDKInit(&this,NOTOK, null); //important 
		Bool res = C4DOS.Bc.CopyTo(&tmp, &this,COPYFLAGS_0,null);

		tmp.dummy1 = null;
		tmp.dummy2 = 0;
		tmp.dummy3 = 0;
		tmp.dummy4 = 0;
		tmp.dummy5 = 0;
		//printf("copy %i \n",res);
	}

	this(Int32 id /*= NOTOK*/){ C4DOS.Bc.SDKInit(&this,id, null); }
	this()(auto ref const(BaseContainer) src){ C4DOS.Bc.SDKInit(&this, NOTOK, &src); } //! auto ref
	~this() { FlushAll(); }

	//ref const BaseContainer  operator = (ref const BaseContainer  n);
	BaseContainer* GetClone(COPYFLAGS flags, AliasTrans* trans) const { return C4DOS.Bc.GetClone(&this, flags, trans); }
	Bool CopyTo(BaseContainer* dst, COPYFLAGS flags, AliasTrans* trans) const { return C4DOS.Bc.CopyTo(&this, dst, flags, trans); }

	void FlushAll() { C4DOS.Bc.FlushAll(&this ); }

	Int32 GetId() const { return C4DOS.Bc.GetId(&this ); }
	void SetId(Int32 c_id){ C4DOS.Bc.SetId(&this, c_id); }
	UInt32 GetDirty() const { return C4DOS.Bc.GetDirty(&this ); }

	Bool RemoveData(Int32 id) { return C4DOS.Bc.RemoveData(&this, id); }
	Bool RemoveIndex(Int32 i) { return C4DOS.Bc.RemoveIndex(&this, i); }

	Int32 FindIndex(Int32 id, GeData** ppData = null) const { return C4DOS.Bc.FindIndex(&this, id, ppData); }
	Int32 GetIndexId(Int32 index) const { return C4DOS.Bc.GetIndexId(&this, index); }
	GeData* GetDataPointer(Int32 id) const { return C4DOS.Bc.GetDataPointer(&this, id); }
	void GetDataPointers(const Int32* ids, Int32 cnt, const GeData** data) const { C4DOS.Bc.GetDataPointers(&this, ids, cnt, data); }

	GeData* GetIndexData(Int32 index) const { return C4DOS.Bc.GetIndexData(&this, index); }
	GeData* InsData(Int32 id, ref const GeData  n) { return C4DOS.Bc.InsData(&this, id, n); }
	GeData* InsDataAfter(Int32 id, ref const GeData  n, GeData* last) { return C4DOS.Bc.InsDataAfter(&this, id, n, last); }
	GeData* SetData()(Int32 id,auto ref const GeData  n) { return C4DOS.Bc.SetData(&this, id, n); }
	ref const(GeData) GetData(Int32 id) const { return C4DOS.Bc.GetData(&this, id); } //todo ref problem 

	// operator ==,  operator !=
	bool opEquals(in BaseContainer rhs) const  {
		return cast(bool)C4DOS.Bc.Compare(this, rhs); //return Compare(rhs) == 0;
	}
	bool opEquals(ref const BaseContainer rhs) const  {
		return cast(bool)C4DOS.Bc.Compare(this, rhs); //return Compare(rhs) == 0;
	}

	Bool	GetBool		(Int32 id, Bool preset = false) const { return C4DOS.Bc.GetBool(&this, id, preset); }
	Int32	GetInt32	(Int32 id, Int32 preset = 0) const { return C4DOS.Bc.GetInt32(&this, id, preset); }
	UInt32 GetUInt32	(Int32 id, UInt32 preset = 0) const { return C4DOS.Bc.GetUInt32(&this, id, preset); }
	Int64	GetInt64	(Int32 id, Int64 preset = 0) const { return C4DOS.Bc.GetInt64(&this, id, preset); }
	UInt64 GetUInt64	(Int32 id, UInt64 preset = 0) const { return C4DOS.Bc.GetUInt64(&this, id, preset); }
	Float	GetFloat	(Int32 id, Float preset = 0.0) const { return C4DOS.Bc.GetFloat(&this, id, preset); }
	void*	GetVoid		(Int32 id, void* preset = null) const { return C4DOS.Bc.GetVoid(&this, id, preset); }
	//? void * GetMemoryAndRelease	(Int32 id, ref Int  count, void * preset = null) { return C4DOS.Bc.GetMemoryAndRelease(&this, id, count, preset); }
	//? void * GetMemory		(Int32 id, ref Int  count, void * preset = null) const { return C4DOS.Bc.GetMemory(&this, id, count, preset); }
	
	//!default value problem !!!
	//Vector GetVector	 (Int32 id, in Vector preset) const { return C4DOS.Bc.GetVector(&this, id, preset); }
	//Vector GetVector	 (Int32 id, ref const Vector preset) const { return C4DOS.Bc.GetVector(&this, id, preset); }

	Vector GetVector	 (Int32 id, in Vector preset = Vector(0.0)) const { Vector ret;  C4DOS.Bc.GetVector(&this,&ret, id, preset); return ret; }
	Matrix GetMatrix	 (Int32 id, in Matrix preset = Matrix()) const { Matrix ret;  C4DOS.Bc.GetMatrix(&this,&ret, id, preset); return ret; }
	String GetString	 (Int32 id, in String preset = String()) const { String ret;  C4DOS.Bc.GetString(&this,&ret, id, preset); return ret; }
	Filename GetFilename (Int32 id, in Filename preset = Filename()) const { Filename ret;  C4DOS.Bc.GetFilename(&this,&ret, id, preset); return ret; }
	BaseTime GetTime	 (Int32 id, in BaseTime preset = BaseTime()) const { BaseTime ret; C4DOS.Bc.GetTime(&this,&ret, id, preset); return ret; }


	//Vector GetVector	 (Int32 id) const { Vector preset = Vector(0.0); return C4DOS.Bc.GetVector(&this, id, preset); }
	//Matrix GetMatrix	 (Int32 id) const { Matrix preset = Matrix(); return C4DOS.Bc.GetMatrix(&this, id, preset); }
	//String GetString	 (Int32 id) const { String preset = String(); return C4DOS.Bc.GetString(&this, id, preset); }
	//Filename GetFilename (Int32 id) const { Filename preset = Filename(); return C4DOS.Bc.GetFilename(&this, id, preset); }
	//? BaseTime GetTime	 (Int32 id) const { BaseTime preset = BaseTime(); return C4DOS.Bc.GetTime(&this, id, preset); }

	//Vector GetVector	 (Int32 id, ref const Vector  preset = Vector()) const { return C4DOS.Bc.GetVector(&this, id, preset); }
	//Matrix GetMatrix	 (Int32 id, ref const Matrix  preset = Matrix()) const { return C4DOS.Bc.GetMatrix(&this, id, preset); }
	//String GetString	 (Int32 id, ref const String  preset = String()) const { return C4DOS.Bc.GetString(&this, id, preset); }
	//C4DUuid	GetUuid			(Int32 id, ref const C4DUuid  preset = C4DUuid(DC)) const { return C4DOS.Bc.GetUuid(&this, id, preset); }
	//Filename GetFilename (Int32 id, ref const Filename  preset = Filename()) const { return C4DOS.Bc.GetFilename(&this, id, preset); }
	//BaseTime GetTime		 (Int32 id, ref const BaseTime  preset = BaseTime()) const { return C4DOS.Bc.GetTime(&this, id, preset); }

	
	BaseContainer		GetContainer(Int32 id) const { BaseContainer ret; C4DOS.Bc.GetContainer(&this,&ret, id); return ret; }
	//BaseContainer		GetContainer(Int32 id) const { return C4DOS.Bc.GetContainer(&this, id); }

	BaseContainer*		GetContainerInstance(Int32 id) const { return C4DOS.Bc.GetContainerInstance(&this, id); }
	BaseList2D*			GetLink					(Int32 id, const BaseDocument* doc, Int32 instanceof = 0) const { return C4DOS.Bc.GetLink(&this, id, doc, instanceof); }
	BaseObject*			GetObjectLink		(Int32 id, const BaseDocument* doc) const;
	BaseMaterial*		GetMaterialLink	(Int32 id, const BaseDocument* doc) const;
	BaseLink*			GetBaseLink (Int32 id) const;
	CustomDataType*	GetCustomDataType	(Int32 id, Int32 datatype) const;

	Int32	GetType(Int32 id) const;

	void SetBool			(Int32 id, Bool b) { return C4DOS.Bc.SetBool(&this, id, b); }
	void SetInt32			(Int32 id, Int32 l) { return C4DOS.Bc.SetInt32(&this, id, l); }
	void SetUInt32			(Int32 id, UInt32 l) { return C4DOS.Bc.SetUInt32(&this, id, l); }
	void SetInt64			(Int32 id, Int64 l) { return C4DOS.Bc.SetInt64(&this, id, l); }
	void SetUInt64			(Int32 id, UInt64 l) { return C4DOS.Bc.SetUInt64(&this, id, l); }
	void SetFloat			(Int32 id, Float r) { return C4DOS.Bc.SetFloat(&this, id, r); }
	void SetVoid			(Int32 id, void * v) { return C4DOS.Bc.SetVoid(&this, id, v); }
	//? void SetMemory		(Int32 id, void * mem, Int count) { C4DOS.Bc.SetMemory(&this, id, mem, count); }
	//void SetVector		(Int32 id, ref const Vector  v) { return C4DOS.Bc.SetVector(&this, id, v); }
	//void SetVector			(Int32 id, in Vector v) { return C4DOS.Bc.SetVector(&this, id, v); }
	void SetVector()		(Int32 id,auto ref const Vector  v) { return C4DOS.Bc.SetVector(&this, id, v); }

	void SetMatrix			(Int32 id, ref const Matrix  m) { return C4DOS.Bc.SetMatrix(&this, id, m); }
	//void SetString			(Int32 id,in String  s) { return C4DOS.Bc.SetString(&this, id, s); }
	void SetString			(Int32 id,ref const String  s) { return C4DOS.Bc.SetString(&this, id, s); }
	//? void SetUuid		(Int32 id, ref const C4DUuid  u) { return C4DOS.Bc.SetUuid(&this, id, u); }
	void SetFilename		(Int32 id, ref const Filename  f) { return C4DOS.Bc.SetFilename(&this, id, f); }
	void SetTime			(Int32 id, ref const BaseTime  b) { return C4DOS.Bc.SetTime(&this, id, b); }
	void SetTime			(Int32 id, in BaseTime  b) { return C4DOS.Bc.SetTime(&this, id, b); }

	void SetContainer		(Int32 id, ref const BaseContainer  s) { return C4DOS.Bc.SetContainer(&this, id, s); }
	void SetLink				(Int32 id, C4DAtomGoal* link) { return C4DOS.Bc.SetLink(&this, id, link); }

	void MergeContainer(ref const BaseContainer  src);

	//? Bool GetParameter(ref const DescID  id, ref GeData  t_data) const { return C4DOS.Bc.GetParameter(&this, id, t_data); }
	//? Bool SetParameter(ref const DescID  id, ref const GeData  t_data) { return C4DOS.Bc.SetParameter(&this, id, t_data); }

	void Sort() { C4DOS.Bc.Sort(&this, ); }
};


static assert(BaseContainer.sizeof==32,"sizeof BaseContainer is not 32 bytes !");


unittest
{
if(C4DOS) {
	import std.conv;

	BaseContainer bc;
	assert(bc.GetId() == NOTOK);

	//BaseContainer bc2 = NOTOK;
	//printf("BaseContainer %p %i %i %i %i \n",bc2.dummy1,bc2.dummy2,bc2.dummy3,bc2.dummy4,bc2.dummy5);

	bc.SetId(123);
	assert(bc.GetId() == 123);

	bc.SetInt32(1001,753);
	assert(bc.GetInt32(1001) == 753);

	bc.SetUInt32(1002,2753);
	assert(bc.GetUInt32(1002) == 2753,to!string(bc.GetUInt32(1002)));

	bc.SetInt64(1003,12753);
	assert(bc.GetInt64(1003) == 12753);

	bc.SetUInt64(1004,12753);
	assert(bc.GetUInt64(1004) == 12753);

	bc.SetFloat(1005,3.14159265);
	assert(bc.GetFloat(1005) == 3.14159265,to!string(bc.GetFloat(1005)));

	GeData gd;
	gd.SetString(String("string"));
	bc.SetData(1007,gd);
	assert(bc.GetData(1007)==gd);
	assert(bc.GetData(1007).GetString()==String("string"));

	void* ptr = &bc;
	bc.SetVoid(1008,ptr);
	assert(bc.GetVoid(1008) == ptr);


	//printf(" SetTime >>> \n");
	bc.SetTime(1009,BaseTime(1));
	//printf(" GetTime >>> \n");
	//BaseTime preset;
	//BaseTime ret;
	//C4DOS.Bc.GetTime(&bc, &ret,  1009, preset);

	//C4DOS.Bc.GetTime(&bc, 1009, preset);
	//C4DOS.Bc.GetTime(&ret, &bc, 1009, preset);
	//bc.GetTime(1009);
	assert(bc.GetTime(1009,BaseTime(0)) == BaseTime(1));
	//printf(" GetTime %f %f <<< \n",ret.numerator,ret.denominator);
	assert(bc.GetTime(1009) == BaseTime(1));

	{ 
		BaseContainer bc1 = NOTOK;
		Vector v;
		//assert(v == Vector(0,0,0) );
		static assert(Vector(1,2,3) == Vector(1,2,3) );

		//printf(" SetVector >>> \n");
		bc1.SetVector(1006,Vector(1,2,3));

		/*printf(" GetVector0 >>> \n");
		Vector v0;
		auto vpp = C4DOS.Bc.GetVector(&bc1, 1006, v);//! CRASH !!!
		printf(" assert0 >>> %f %f %f \n",v0.x,v0.y,v0.z);
		assert(v0 == Vector(1,2,3) );*/

		//printf(" GetVector1 >>> \n");
		//Vector v1 = bc1.GetVector(1006,v);
		//printf(" v1 >>> %f %f %f \n",v1.x,v1.y,v1.z);
		assert(bc1.GetVector(1006,v) == Vector(1,2,3) );

		//printf(" GetVector2 >>> \n");
		//Vector v2 = bc1.GetVector(1006);
		//printf(" v2 >>> %f %f %f \n",v2.x,v2.y,v2.z);
		assert(bc1.GetVector(1006) == Vector(1,2,3) );

	}





	String s0 = "test";
	bc.SetString(1000,s0);
	//bc.SetString(1000,String("test"));

	//printf(" GetString try >>> \n");
	String s1 = "hm";
	String s = bc.GetString(1000,s1); //! CRASH !!!
	//assert(bc.GetString(1000) == String("test"));
	//assert(bc.GetString(1000,String("")) == String("test")); //crash !!!


	{ //copy test 
		BaseContainer copy = bc;
		
		assert(bc==copy);
	}
	assert(bc.GetId() == 123);


	assert(String("test") == String("test"));
	
	//printf(" done >>> \n");

	//auto s = bc.GetString(1000);
	//auto s = bc.GetString(1000,String(""));

	//? assert(bc.GetString(1000) == String("test")); //crash !!!
	//assert(bc.GetString(1000,String("")) == String("test")); //crash !!!

	//printf(" <<<< BaseContainer \n");
} //if(C4DOS)
}