/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
// Ported from C++ by Remotion (remotion4d.net)			   //
/////////////////////////////////////////////////////////////
module c4d_math;

public import std.math;
public import c4d;

import re_meta; 

enum EPSILON90 =	0.997;	//EPSILON for 90 degrees
enum EPSILON   =	0.0001;
enum EPSILON5  =	1e-5;	//0.00001
enum EPSILON6  =	1e-6;
enum EPSILON7  =	1e-7;
enum EPSILON8  =	1e-8;
enum EPSILON10 =	1e-10;
enum EPSILON12 =	1e-12;
enum EPSILON16 =	1e-16;


enum Float32 MINVALUE_FLOAT32 = -3.402823466e+38f;					///< the minimum value a Float32 can represent
enum Float32 MAXVALUE_FLOAT32 =  3.402823466e+38f;					///< the maximum value a Float32 can represent

enum Float64 MINVALUE_FLOAT64 = -1.7976931348623158e+308;			///< the minimum value a Float64 can represent
enum Float64 MAXVALUE_FLOAT64 =  1.7976931348623158e+308;			///< the maximum value a Float64 can represent

enum Float32 MINVALUE_INT32_FLOAT32 = -2147483520.0f;				///< minimum Float32 value that can be represented by Int32 (-0x7FFFFF80). Lower values will results in an overflow
enum Float32 MAXVALUE_INT32_FLOAT32	=  2147483520.0f;				///< maximum Float32 value that can be represented by Int32 ( 0x7FFFFF80). Higher values will results in an overflow

enum Float64 MINVALUE_INT64_FLOAT64 = -9223372036854775295.0;		///< minimum Float64 value that can be represented by Int64 (-0x7ffffffffffffdff). Lower values will results in an overflow
enum Float64 MAXVALUE_INT64_FLOAT64 =  9223372036854775295.0;		///< maximum Float64 value that can be represented by Int64 ( 0x7ffffffffffffdff). Higher values will results in an overflow

enum Float32 MINRANGE_FLOAT32	= -1.0e10f;							///< 'safe' minimum range for Float32. Guarantees that multiplication of two numbers doesn't produce an overflow
enum Float32 MAXRANGE_FLOAT32	=  1.0e10f;							///< 'safe' maximum range for Float32. Guarantees that multiplication of two numbers doesn't produce an overflow

enum Float64 MINRANGE_FLOAT64   = -1.0e100;							///< 'safe' minimum range for Float. Guarantees that multiplication of two numbers doesn't produce an overflow
enum Float64 MAXRANGE_FLOAT64	=  1.0e100;							///< 'safe' maximum range for Float. Guarantees that multiplication of two numbers doesn't produce an overflow

static if(__FLOAT_32_BIT) {
enum Float MINVALUE_FLOAT = MINVALUE_FLOAT32;						///< the minimum value a Float can represent
enum Float MAXVALUE_FLOAT = MAXVALUE_FLOAT32;						///< the maximum value a Float can represent

enum Float MINRANGE_FLOAT = MINRANGE_FLOAT32;						///< 'safe' minimum range for Float64. Guarantees that multiplication of two numbers doesn't produce an overflow
enum Float MAXRANGE_FLOAT = MAXRANGE_FLOAT32;						///< 'safe' maximum range for Float64. Guarantees that multiplication of two numbers doesn't produce an overflow
} else {
enum Float MINVALUE_FLOAT = MINVALUE_FLOAT64;						///< the minimum value a Float can represent
enum Float MAXVALUE_FLOAT = MAXVALUE_FLOAT64;						///< the maximum value a Float can represent

enum Float MINRANGE_FLOAT = MINRANGE_FLOAT64;						///< 'safe' minimum range for Float64. Guarantees that multiplication of two numbers doesn't produce an overflow
enum Float MAXRANGE_FLOAT = MAXRANGE_FLOAT64;						///< 'safe' maximum range for Float64. Guarantees that multiplication of two numbers doesn't produce an overflow
}


/// Class to determine the limits of a datatype. Use LIMIT<type>::Min() or LIMIT<type>::Max() to return the minimum or maximum values that can be represented by the datatype.
/// You can also use the LIMIT<type>::MIN or LIMIT<type>::MAX for integer datatypes (this doesn't work for floating point types though).
struct LIMIT(T){ };

struct LIMIT(T : Int64){
	static const Int64 MIN = -9223372036854775807 - 1;
	static const Int64 MAX =  9223372036854775807;

	static Int64 Min() { return -9223372036854775807 - 1; }
	static Int64 Max() { return  9223372036854775807; }
};
static assert(LIMIT!Int64.MIN == (-9223372036854775807 - 1));
static assert(LIMIT!Int64.MAX == (9223372036854775807));


struct LIMIT(T : UInt64){
	static const UInt64 MIN = 0;
	static const UInt64 MAX = 0xffffffffffffffff;

	static UInt64 Min() { return 0; }
	static UInt64 Max() { return 0xffffffffffffffff; }
};
static assert(LIMIT!UInt64.MIN == 0);
static assert(LIMIT!UInt64.MAX == (0xffffffffffffffff));


struct LIMIT(T : Int32){
	static const Int32 MIN = -2147483647L - 1;
	static const Int32 MAX =  2147483647L;

	static Int32 Min() { return -2147483647L - 1; }
	static Int32 Max() { return 2147483647L; }
};
static assert(LIMIT!Int32.MIN == (-2147483647L - 1));
static assert(LIMIT!Int32.MAX == (2147483647L));



enum Int NOTOK		= -1; ///< constant used for special cases
//pragma(msg,typeof(NOTOK));

/+
enum _DONTCONSTRUCT  { /// Don't Construct
	DC 		//Pass this element to use the no-op constructor.
} mixin EnumUpScope!(_DONTCONSTRUCT); //mixin ENUM_END_FLAGS!(_DONTCONSTRUCT);


enum _EMPTYCONSTRUCT  { /// Empty Construct
	EC  		//Pass this element to use the no-op empty constructor.
} mixin EnumUpScope!(_EMPTYCONSTRUCT); //mixin ENUM_END_FLAGS!(_EMPTYCONSTRUCT);

enum _INITTCONSTRUCT  { /// Init Construct, this should replace default constructor
	IC 		//Pass this element to use the default initializer constructor.
} mixin EnumUpScope!(_INITTCONSTRUCT); //mixin ENUM_END_FLAGS!(_EMPTYCONSTRUCT);
+/

struct _DONTCONSTRUCT {}; /// Don't Construct
enum DC = _DONTCONSTRUCT();

struct _EMPTYCONSTRUCT {}; /// Empty Construct
enum EC = _EMPTYCONSTRUCT();

struct _INITTCONSTRUCT {}; /// Init Construct, this should replace default constructor
enum IC = _INITTCONSTRUCT();
enum DEFAULT = _INITTCONSTRUCT();

//enum TRUE			= 1;
//enum FALSE		= 0;
enum NULL			= null; //???
enum nullptr		= null; //???	

/// floating point constant: PI
//? enum Float64 PI				= 3.1415926535897932384626433832795;  //conflict with math.d ??

/// floating point constant: 1.0 / PI
enum Float64 PI_INV			= 0.31830988618379067153776752674508;

/// floating point constant: 2.0 * PI
enum Float64 PI2			= 6.283185307179586476925286766559;

/// floating point constant: 1.0 / (2.0 * PI)
enum Float64 PI2_INV		= 0.15915494309189533576888376337251;

/// floating point constant: 0.5 * PI
enum Float64 PI05			= 1.5707963267948966192313216916398;


//all following function should be 
@nogc:
@safe: 
nothrow:


/// Clip a floating point number against the lower limit 0 and the upper limit 1. The result will be returned.
Float32 Clamp01(Float32 a) @safe pure nothrow { if (a < 0.0f) return 0.0f; if (a > 1.0f) return 1.0f; return a; }

/// Clip a floating point number against the lower limit 0 and the upper limit 1. The result will be returned.
Float64 Clamp01(Float64 a) @safe pure nothrow { if (a < 0.0) return 0.0; if (a > 1.0) return 1.0; return a; }

//Float32 Sqrt(Float32 val) { return sqrt(val); }
//Float64 Sqrt(Float64 val) { return sqrt(val); }

Float32 Sin(Float32 val) @safe pure nothrow { return sin(val); }
Float64 Sin(Float64 val) @safe pure nothrow { return sin(val); }

Float32 Cos(Float32 val) @safe pure nothrow { return cos(val); }
Float64 Cos(Float64 val) @safe pure nothrow { return cos(val); }

Float32 Tan(Float32 val) @safe pure nothrow { return tan(val); }
Float64 Tan(Float64 val) @safe pure nothrow { return tan(val); }

Float32 ATan(Float32 val) @safe pure nothrow { return atan(val); }
Float64 ATan(Float64 val) @safe pure nothrow { return atan(val); }

Float32 ATan2(Float32 valA, Float32 valB) @safe pure nothrow { return atan2(valA, valB); }
Float64 ATan2(Float64 valA, Float64 valB) @safe pure nothrow { return atan2(valA, valB); }

Float32 Exp(Float32 val) @safe pure nothrow { return exp(val); }
Float64 Exp(Float64 val) @safe pure nothrow { return exp(val); }

Float32 Ln(Float32 val) @safe pure nothrow { return log(val); }
Float64 Ln(Float64 val) @safe pure nothrow { return log(val); }

Float32 Log10(Float32 val) @safe pure nothrow { return log10(val); }
Float64 Log10(Float64 val) @safe pure nothrow { return log10(val); }

Float32 Log2(Float32 val) @safe pure nothrow { return log2(val); }
Float64 Log2(Float64 val) @safe pure nothrow { return log2(val); }

Float32 Sqrt(Float32 val) @safe pure nothrow { return sqrt(val); }
Float64 Sqrt(Float64 val) @safe pure nothrow { return sqrt(val); }

Float32 Floor(Float32 val) @safe pure nothrow { return floor(val); }
Float64 Floor(Float64 val) @safe pure nothrow { return floor(val); }

Float32 Ceil(Float32 val) @safe pure nothrow { return ceil(val); }
Float64 Ceil(Float64 val) @safe pure nothrow { return ceil(val); }

//Float32 Modf(Float32 val, Float32* intpart) { return modf(val, intpart); }
//Float64 Modf(Float64 val, Float64* intpart) { return modf(val, intpart); }

Float32 Pow(Float32 v1, Float32 v2) @safe pure nothrow { return pow(v1, v2); }
Float64 Pow(Float64 v1, Float64 v2) @safe pure nothrow { return pow(v1, v2); }

Float32 Sinh(Float32 val) @safe pure nothrow { return sinh(val); }
Float64 Sinh(Float64 val) @safe pure nothrow { return sinh(val); }

Float32 Cosh(Float32 val) @safe pure nothrow { return cosh(val); }
Float64 Cosh(Float64 val) @safe pure nothrow { return cosh(val); }

Float32 Tanh(Float32 val) @safe pure nothrow { return tanh(val); }
Float64 Tanh(Float64 val) @safe pure nothrow { return tanh(val); }

Float32 FMod(Float32 v1, Float32 v2) @safe nothrow { return fmod(v1, v2); } //not pure
Float64 FMod(Float64 v1, Float64 v2) @safe nothrow { return fmod(v1, v2); } //not pure

Float32 Abs(Float32 val) @safe pure nothrow { return fabs(val); }
Float64 Abs(Float64 val) @safe pure nothrow { return fabs(val); }


/// Calculates the reciprocal value (multiplicative inverse). If the input value is zero, zero will be returned for safety to avoid exceptions.
Float32 Inverse(Float32 f) @safe pure nothrow { return (f == 0.0f) ? 0.0f : 1.0f / f; }

/// Calculates the reciprocal value (multiplicative inverse). If the input value is zero, zero will be returned for safety to avoid exceptions.
Float64 Inverse(Float64 f) @safe pure nothrow { return (f == 0.0) ? 0.0 : 1.0 / f; }


/// Calculates the absolute value of any data type
 X Abs ( X)(X f) @safe pure nothrow { if (f < 0) return -f; return f; }

/// Calculates the minimum of two values and return it.
 X Min ( X)(X a, X b) @safe pure nothrow { if (a < b) return a; return b; }

/// Calculates the maximum of two values and return it.
 X Max ( X)(X a, X b) @safe pure nothrow { if (a < b) return b; return a; }

/// Swaps two values. If available, move semantics will be used.
//? void Swap ( X)(ref X  a, ref X  b) { X c = X(std.move(a)); a = std.move(b); b = std.move(c); }

/// Clips a value against a lower and upper limit. The new value is returned.
 X ClampValue ( X)(X value, X lowerLimit, X upperLimit) @safe pure nothrow { if (value < lowerLimit) return lowerLimit; if (value > upperLimit) return upperLimit; return value; }

/// Clips a value against a lower and upper limit. The new value is returned.
 X Blend ( X,  Y)(ref const X  value1, ref const X  value2, Y blendValue) @safe pure nothrow { return X(value1 + (value2 - value1) * blendValue); }

/// Calculates square difference of two values
 Float Sqr ( X)(X a, X b) @safe pure nothrow { X tmp = a-b; return tmp*tmp; }

/// Calculates square of a value
 Float Sqr ( X)(X a) @safe pure nothrow { return a*a; }

/// Calculates arcsine. The input value is clipped for safety to avoid exceptions.
Float32 ASin(Float32 val) @safe pure nothrow { if (val >= 1.0f) return (PI05); else if (val <= -1.0f) return (-PI05); return asin(val); }

/// Calculates arcsine. The input value is clipped for safety to avoid exceptions.
Float64 ASin(Float64 val) @safe pure nothrow { if (val >= 1.0f) return (PI05); else if (val <= -1.0f) return (-PI05); return asin(val); }

/// Calculates arccosine. The input value is clipped for safety to avoid exceptions.
Float32 ACos(Float32 val) @safe pure nothrow { if (val >= 1.0f) return 0.0f; else if (val <= -1.0f) return (PI); return acos(val); }

/// Calculates arccosine. The input value is clipped for safety to avoid exceptions.
Float64 ACos(Float64 val) @safe pure nothrow { if (val >= 1.0f) return 0.0f; else if (val <= -1.0f) return (PI); return acos(val); }

/// Converts float value from degrees to radians
Float32 Rad(Float32 r) @safe pure nothrow  { return ((r)*(PI)/180.0f); }

/// Converts float value from degrees to radians
Float64 Rad(Float64 r) @safe pure nothrow  { return ((r)*PI/180.0); }

/// Converts float value from radians to degrees
Float32 Deg(Float32 r) @safe pure nothrow  { return ((r)*180.0f/(PI)); }

/// Converts float value from radians to degrees
Float64 Deg(Float64 r) @safe pure nothrow  { return ((r)*180.0/PI); }

void SinCos(Float32 r, ref Float32  sn, ref Float32  cs) @safe pure nothrow { sn = Sin(r); cs = Cos(r); }
void SinCos(Float64 r, ref Float64  sn, ref Float64  cs) @safe pure nothrow { sn = Sin(r); cs = Cos(r); }

//----------------------------------------------------------------------------------------
/// Assigns the maximum of two values to the first value.
/// @param[in,out] a							First value.
/// @param[in] b									Second value.
//----------------------------------------------------------------------------------------
void SetMax ( T)(ref T  a, ref const T  b) @safe pure nothrow {
	if (b > a)	{
		a = b;
	}
}

//----------------------------------------------------------------------------------------
/// Assigns the minimum of two values to the first value.
/// @param[in,out] a							First value.
/// @param[in] b									Second value.
//----------------------------------------------------------------------------------------
void SetMin ( T)(ref T  a, ref const T  b) @safe pure nothrow {
	if (b < a)	{
		a = b;
	}
}


Float32 FMin(Float32 a, Float32 b) @safe pure nothrow
{
	if (a < b)
		return a;
	return b;
}
Float64 FMin(Float64 a, Float64 b) @safe pure nothrow
{
	if (a < b)
		return a;
	return b;
}
Int32 LMin(Int32 a, Int32 b) @safe pure nothrow
{
	if (a < b)
		return a;
	return b;
}
Int VMin(Int a, Int b) @safe pure nothrow
{
	if (a < b)
		return a;
	return b;
}

Float32 FMax(Float32 a, Float32 b) @safe pure nothrow
{
	if (a < b)
		return b;
	return a;
}
Float64 FMax(Float64 a, Float64 b) @safe pure nothrow
{
	if (a < b)
		return b;
	return a;
}
Int32 LMax(Int32 a, Int32 b) @safe pure nothrow
{
	if (a < b)
		return b;
	return a;
}
Int VMax(Int a, Int b) @safe pure nothrow
{
	if (a < b)
		return b;
	return a;
}

Int32 LCut(Int32 a, Int32 b, Int32 c) @safe pure nothrow
{
	if (a < b)
		return b;
	if (a > c)
		return c;
	return a;
}
Int VCut(Int a, Int b, Int c) @safe pure nothrow
{
	if (a < b)
		return b;
	if (a > c)
		return c;
	return a;
}

/// Calculates the sign of a value. If the value is 0 or positive the result is 1, otherwise -1.
 Int Sign ( X)(X f) @safe pure nothrow {
	if (f < cast(X)0)
		return -1;
	return 1;
}

 T Mod ( T,  U)(T a, U b) @safe pure nothrow {
	return a < 0 ? a - (((a - b + 1) / b) * b) : a % b;
}



/// IsNaN
 bool IsNaN(Float32 x)  @safe pure nothrow {
	 // This looks like it should always be false, but it's true if x is a NaN.
	 return (x != x); 
 }
 bool IsNaN(Float64 x)  @safe pure nothrow {
	 // This looks like it should always be false, but it's true if x is a NaN.
	 return (x != x); 
 }
static assert(IsNaN(float.init));
static assert(IsNaN(double.init));

//static assert(IsNaN(float.infinity));
//static assert(IsNaN(double.infinity));

static assert(!IsNaN(0.0f));
static assert(!IsNaN(0.0));


/// IsFinite
 bool IsFinite(Float32 x)  @safe pure nothrow {
	 return (MINVALUE_FLOAT32 <= x && x <= MAXVALUE_FLOAT32);
 }  
 bool IsFinite(Float64 x)  @safe pure nothrow {
	 return (MINVALUE_FLOAT64 <= x && x <= MAXVALUE_FLOAT64);
 }  

static assert(IsFinite(0.0));
static assert(IsFinite(-100000.0));
static assert(IsFinite(100000.0));

static assert( ! IsFinite(float.infinity));
static assert( ! IsFinite(double.infinity));

static assert( ! IsFinite(float.init));
static assert( ! IsFinite(double.init));


/// Integer flooring.
long lfloor(T)(T x) nothrow {// may be pure but floor isn't pure
	 //return cast(int)(floor(x));
	return cast(int)(x); //test only 
}
static assert( lfloor( 1.1324)  ==  1 );
static assert( lfloor(-1.1324) == -1 );

 /// Returns: Fractional part of x.
 T fract(T)(T x) nothrow {
	 return x - lfloor(x);
 }
 //static assert( fract(1.1234) == 0.1234 );
 //pragma(msg, fract(1.1234));


//pragma(msg, float.min); //deprecated
//pragma(msg, float.min_normal);	//1.17549e-38
//pragma(msg, float.max);			//3.40282e+38
//pragma(msg, float.epsilon );		//1.19209e-07
//pragma(msg, float.infinity );

//pragma(msg, double.min); //deprecated
//pragma(msg, double.min_normal);	//2.22507e-308
//pragma(msg, double.max);			//1.79769e+308
//pragma(msg, double.epsilon );		//2.22045e-16
//pragma(msg, double.infinity );