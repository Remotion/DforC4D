module c4d_basedata;

import c4d;
import c4d_os;

import core.stdc.stdio : printf;

//=============================================================================
/// The base class for all plugin data classes.
//=============================================================================
//extern (C++) 
class BaseData
{
public:
	 this()  {}
	~this() {}

	//this()  { printf("BaseData.this >\n"); }
	//~this() { printf("BaseData.~this <\n"); }

	/// Frees this base data object.
	final void Destructor()	
	{
		//printf("BaseData::Destructor >>> \n");

		/* //wrong ?
		BaseData* _this;
		_this = &this;
		gDelete( _this ); //DeleteObj(_this);
		*/

		BaseData _this;
		_this = this;
		destroy(_this); 

		//printf("<<< BaseData::Destructor \n");
	}
};


static if(__MAC) {
	enum C4DPL_MEMBERMULTIPLIER = 2;
} else static if(__PC) {
	enum C4DPL_MEMBERMULTIPLIER = 1;
}else{
	enum C4DPL_MEMBERMULTIPLIER = 2;
}

static assert(C4DPL_MEMBERMULTIPLIER==1); //PC


//=============================================================================
extern (C++) 
struct BASEPLUGIN
{
	Int32	info;
	void    function(BaseData self) Destructor; //void	(BaseData::*Destructor)();
	void*	reserved[(8 - 1) * C4DPL_MEMBERMULTIPLIER - 1];
};

//pragma(msg, struct_diagram!BASEPLUGIN);
//pragma(msg, BASEPLUGIN.sizeof);
static assert(BASEPLUGIN.sizeof==64,BASEPLUGIN.sizeof); //PC


//=============================================================================
extern (C++) 
struct STATICPLUGIN //: public BASEPLUGIN
{
	BASEPLUGIN parent; //?
	alias parent this; //? 

	BaseData adr; //BaseData* adr;
	void*	reserved[(8 - 0) * C4DPL_MEMBERMULTIPLIER - 1];
};

//pragma(msg, struct_diagram!STATICPLUGIN);
static assert(STATICPLUGIN.sizeof==128,STATICPLUGIN.sizeof); //PC

