/////////////////////////////////////////////////////////////
// CINEMA 4D SDK                                           //
/////////////////////////////////////////////////////////////
// (c) MAXON Computer GmbH, all rights reserved            //
// Ported from C++ by Remotion (remotion4d.net)			   //
/////////////////////////////////////////////////////////////
module c4d_vector;

import c4d;
import c4d_os;

public import c4d_math;
//? import core.simd;

//public import c4d_prepass;// : _DONTCONSTRUCT, DC;
//public import c4d_prepass : _DONTCONSTRUCT, DC;

import std.traits : isNumeric, isFloatingPoint;

alias VectorT!(Float)		Vector;		//per default double3
alias VectorT!(Float32)		Vector32;	//float3
alias VectorT!(Float64)		Vector64;	//double3 


//=============================================================================
/// Generic 3d vector/point
/// params: 
///    T = type of elements
//=============================================================================
struct VectorT(T)  if (isNumeric!T) 
{
@nogc:
@safe:
pure:
nothrow:

public:  /// data
	union	{
		struct {
			T x  = 0;	//x coordinate
			T y  = 0;	//y coordinate
			T z  = 0;	//z coordinate
		}
		T[3] v = void;
	}

public:

	/// CTor's
	this(_DONTCONSTRUCT dc)  pure nothrow {  }

	this(_INITTCONSTRUCT ic)  pure nothrow { x = (0); y = (0); z = (0); }

	/// Construct a Vector from a single value.
	this(U : T)(U r)  pure nothrow 
		//if( ! is(U : _DONTCONSTRUCT) && ! is(U : _INITTCONSTRUCT)) //exclude DC and IC
	{ x = (r); y = (r); z = (r); }

	/// Creates a vector of 3 elements.
	this(X : T, Y : T, Z : T)(X ix, Y iy, Z iz)  pure nothrow { x = (ix); y = (iy); z = (iz); }

	/// Construct a Vector from another vector
	this(U : T)(in Vector!(U) v)  pure nothrow { x = (v.x); y = (v.y); z = (v.z); }

	
	this(U : T)(U[3] pos) pure nothrow if (isNumeric!U) {
		x = (pos[0]); y = (pos[1]); z = (pos[2]);
	}


	/// opCall, do we really need this ?
	static VectorT opCall(T r)	{
		VectorT n = void;
		n.x = (r); n.y = (r); n.z = (r);
		return n;
	}

	static VectorT opCall(T ix, T iy, T iz)	{
		VectorT n = void;
		n.x = (ix); n.y = (iy); n.z = (iz);
		return n;
	}

	static VectorT opCall(_DONTCONSTRUCT v)	{ //does not make sense 
		VectorT n = void;
		return n;
	}

	static VectorT opCall(ref const VectorT v)	{
		VectorT n = void;
		n.x = (v.x); n.y = (v.y); n.z = (v.z);
		return n;
	}

	/// Checks if each component is exact zero.
	/// Please be aware about floating point comparison issues !
	Bool IsZero() const	{
		return (x == 0) && (y == 0) && (z == 0);
	}

	/// Checks if one of the components is exact not zero.
	/// Please be aware about floating point comparison issues !
	Bool IsNotZero() const	{
		return (x != 0) || (y != 0) || (z != 0);
	}

	/// Sets all components to zero.
	void SetZero() 	{
		x = 0;
		y = 0;
		z = 0;
	}


	/// Calculates the sum of 'x', 'y' and 'z'
	T GetSum() const	{
		return x + y + z;
	}

	/// Returns the minimum of 'x', 'y' and 'z'
	T GetMin() const	{
		if (x < y) {
			return (z < x) ? z : x;
		} else {
			return (z < y) ? z : y;
		}
	}

	/// Returns the maximum of 'x', 'y' and 'z'
	T GetMax() const	{
		if (x > y)	{
			return (z > x) ? z : x;
		} else {
			return (z > y) ? z : y;
		}
	}

	static if( isFloatingPoint!T ) {

		/// Tests component-wise if the difference is no bigger than 'epsilon'
		Bool IsEqual(ref const VectorT  v2, const T epsilon = cast(T)0.01) const {
			return Abs(x - v2.x) < epsilon && Abs(y - v2.y) < epsilon && Abs(z - v2.z) < epsilon;
		}

		/// Calculates the average value of 'x', 'y' and 'z'
		T GetAverage() const {
			return (x + y + z) * (1.0 / 3.0);
		}

		/// Returns a vector that is clamped to the range [0.0 .. 1.0]
		VectorT Clamp01() const {
			return VectorT(.Clamp01(x), .Clamp01(y), .Clamp01(z));
		}

		/// Returns the length of the vector
		Float64	GetLength() const {
			return Sqrt(x * x + y * y + z * z);
		}

		/// Returns the squared length of the vector
		Float64	GetSquaredLength() const {
			return x * x + y * y + z * z;
		}

		/// Returns a normalized vector, so that GetLength(vector)==1.0
		VectorT GetNormalized() const {
			Float64 l = GetLength();

			if (l == 0.0)
				return VectorT(0.0, 0.0, 0.0);

			l = 1.0 / l;
			return VectorT(x * l, y * l, z * l);
		}

		/// Normalizes this vector, so that GetLength()==1.0
		void Normalize() {
			Float64 l = Sqrt(x * x + y * y + z * z);
			if (l != 0.0) {
				l	 = 1.0 / l;
				x *= l;
				y *= l;
				z *= l;
			}
		}

	} //static if( isFloatingPoint!T )

	///operators
	// http://ddili.org/ders/d.en/operator_overloading.html

	// operator ==,  operator !=
	bool opEquals(U: T)(auto ref const VectorT!U v2) const  {
		return (x == v2.x) && (y == v2.y) && (z == v2.z);
	}
	// operator ==,  operator !=
	bool opEquals(U: T)(auto ref const U r) const  {
		return (x == r) && (y == r) && (z == r);
	}

	// -v, +v
	VectorT opUnary(string op)() const {
		static if (op == "-") {
			return VectorT(-x, -y, -z);
		} else 
		static if (op == "+") {
			return VectorT(+x, +y, +z);
		} 
	}

	// 1.0 + v1;
	VectorT opBinaryRight(string op)(in T s) const {
		static if(op=="+"||op=="-"||op=="*"){
			mixin( "return VectorT(x"~op~"s, y"~op~"s, z"~op~"s);" );
		} 
		else static assert(0, "VectorT Operator "~op~" not implemented");
	}

	// v1 + 1.0;
	VectorT opBinary(string op)(in T s) const {
		static if(op=="+"||op=="-"||op=="*"){
			mixin( "return VectorT(x"~op~"s, y"~op~"s, z"~op~"s);" );
		} else static if(op=="/"){ // divide each vector component by a scalar
			if (s)			{
				const T t = 1.0 / s;
				return VectorT(x * t, y * t, z * t);
			}
			return VectorT(0.0);
		}
		else static assert(0, "VectorT Operator "~op~" not implemented");
	}

	// v1 + v2;   v1 - v2;
	VectorT opBinary(string op)(in VectorT v2) const {
		static if(op=="+"||op=="-"/*||op=="*"*/){
			mixin( "return VectorT(x"~op~"v2.x, y"~op~"v2.y, z"~op~"v2.z);" );
		} else static if(op=="/"){
			
		}
		else static assert(0, "VectorT Operator "~op~" not implemented");
	}

	// v += 1.0;
	ref VectorT opOpAssign(string op) (in T s) {
		static if	   (op == "+") { x += s;	y += s;	z += s; return this; } //+=
		else static if (op == "-") { x -= s;	y -= s;	z -= s; return this; } //-=
		else static if (op == "*") { x *= s;	y *= s;	z *= s; return this; } //-=
		else static if (op == "/") { 		
			if (s)	{
				const T t = 1.0 / s;
				x *= t; y *= t; z *= t;
			} else {
				x = y = z = 0.0;
			}
			return this; }//-=
		else assert(0, "VectorT Operator "~op~"= not implemented");
	}

	// v += v2;
	ref VectorT opOpAssign(string op) (in VectorT v) {
		static if	   (op == "+") { x += v.x; y += v.y; z += v.z; return this; } //+=
		else static if (op == "-") { x -= v.x; y -= v.y; z -= v.z; return this; } //-=
		else static if (op == "*") { x *= v.x; y *= v.y; z *= v.z; return this; } //*=
		else static assert(0, "VectorT Operator "~op~"= not implemented");
	}


	// For the (object[i .. j] = value) syntax
	/*void opSliceAssign(T value, size_t i, size_t j)
	{
	}

	void opSliceAssign(T value, size_t i)
	{
	}*/



	// op is one of <, <=, >, or >=
	// A negative value if the left-hand object is considered to be before the right-hand object
	//	A positive value if the left-hand object is considered to be after the right-hand object
	//	Zero if the objects are considered to have the same sort order
	/*int opCmp(const ref VectorT v2) const   {
		return (???);
	}*/

	// operator []
	/// access vector component: index 0 is 'x', index 1 is 'y', index 2 is 'z'. All other values must not be used and will crash
	//element access 	opIndex 	collection[i]
	ref T opIndex(size_t i) @system	{
		//static assert(i>0 && i<3);
		// Note: do not replace & 3 by & 2, this will break everything !
		return (&x)[i & 3]; //do not really work ???  //not @safe
	}
	/// access vector component: index 0 is 'x', index 1 is 'y', index 2 is 'z'.  All other values must not be used and will crash
	const(T) opIndex(size_t i) @system const {
		//static assert(i>0 && i<3);
		/*static*/ if(__ctfe){ //compile time execution
			switch(i){
				case 0: return x;
				case 1: return y;
				case 2: return z;
				default: assert(0,"[0 .. 2] wrong index !"); //default: return T.init; 
			}
		} else {
			return (&x)[i & 3]; //i & 3 work until 3 and not 2 as needed.  
		}
	}
	/*
	// unary operation on element 	opIndexUnary 	++collection[i]
	ref T opIndexUnary(string op)(size_t i) {
	static if (op=="++"||op=="--")
	{
		mixin( "return "~op~"((&x)[i]);"); //return ++((&x)[i]);
	} 
	else static assert(0, "VectorT Operator "~op~" not implemented");
	}*/

	/*
	//assignment to element 	opIndexAssign 	collection[i] = 7
	T opIndexAssign(T value, size_t i)
	{
		return (&x)[i] = value;
	}

	// operation with assignment on element 	opIndexOpAssign 	collection[i] *= 2
	ref T opIndexOpAssign(string op)(T value, size_t i)
	if (op=="+"||op=="-"||op=="*") {
		mixin( "return (&x)[i] "~op~"= value;" ); //return (&x)[i] += value;
	} */
}; //VectorT

static assert(Vector.sizeof==24,"sizeof Vector is not 24 bytes !");
static assert(Vector64.sizeof==24,"sizeof Vector64 is not 24 bytes !");
static assert(Vector32.sizeof==12,"sizeof Vector32 is not 12 bytes !");


/// Converts to a pretty string.
string toString(T)(in VectorT!(T) vec) nothrow {
	static if(__ctfe) {
		try {
			import re_meta : ctfe_ftoa;
			return "[" ~ ctfe_ftoa(vec.x) ~","~ ctfe_ftoa(vec.y) ~","~ ctfe_ftoa(vec.z) ~ "]";
		} catch (Exception e) {
			assert(false); // should not happen since format is right
		}
	} else {
		try {
			import std.string : format;
			return format("[%s,%s,%s]", vec.x, vec.y, vec.z);
		} catch (Exception e) {
			assert(false); // should not happen since format is right
		}
	}

}



/+
//todo >>
auto GetAngle(T)(ref const T v1, ref const T v2) //{
	if (is(T == Vector32) || is(T == Vector64)) {
		auto il = Inverse(v1.GetSquaredLength() * v2.GetSquaredLength());
		return ACos((v1.x * v2.x + v1.y * v2.y + v1.z * v2.z) * Sqrt(il));
	} 
	//else static assert(0);
//}
+/
/// Calculates angle (in radians) between v1 and v2
Float64 GetAngle(ref const Vector64 v1, ref const Vector64 v2) pure nothrow @nogc {
	Float64 il = Inverse(v1.GetSquaredLength() * v2.GetSquaredLength());
	return ACos((v1.x * v2.x + v1.y * v2.y + v1.z * v2.z) * Sqrt(il));
}
Float32 GetAngle(ref const Vector32 v1, ref const Vector32 v2)  pure nothrow @nogc {
	Float32 il = Inverse(v1.GetSquaredLength() * v2.GetSquaredLength());
	return ACos((v1.x * v2.x + v1.y * v2.y + v1.z * v2.z) * Sqrt(il));
}
/// Calculates dot product of v1 and v2
Float64 Dot(ref const Vector64 v1, ref const Vector64 v2)  pure nothrow @nogc {
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
Float32 Dot(ref const Vector32 v1, ref const Vector32 v2)  pure nothrow @nogc {
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
Float64 Dot(in Vector64 v1, in Vector64 v2)  pure nothrow @nogc {
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}
Float32 Dot(in Vector32 v1, in Vector32 v2)  pure nothrow @nogc {
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

/// Calculates cross product of v1 and v2
Vector64	Cross(ref const Vector64 v1, ref const Vector64 v2)  pure nothrow @nogc {
	return Vector64(v1.y * v2.z - v1.z * v2.y,
				    v1.z * v2.x - v1.x * v2.z,
				    v1.x * v2.y - v1.y * v2.x);
}
Vector32	Cross(ref const Vector32 v1, ref const Vector32 v2)  pure nothrow @nogc {
	return Vector32(v1.y * v2.z - v1.z * v2.y,
				    v1.z * v2.x - v1.x * v2.z,
				    v1.x * v2.y - v1.y * v2.x);
}
// GetLength()
Float64 Len(/*ref const*/in Vector64 v) @safe  pure nothrow @nogc {
	return Sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}
Float32 Len(/*ref const*/in Vector32 v) @safe  pure nothrow @nogc {
	return Sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}


unittest //####################################################################
{
	static assert(Vector(DEFAULT) == 0.0 && Vector(IC).IsZero && !Vector(IC).IsNotZero );
	static assert(Vector(1) == 1.0 && Vector(1) == Vector(1,1,1));
	static assert(Vector(0.2) == 0.2);
	static assert(Vector([1,2,3]) == Vector(1,2,3));


	static assert(VectorT!int(IC) == 0 && VectorT!int(IC).IsZero && !VectorT!int(IC).IsNotZero );

	//double da = cast(int)(13);

	import std.string : format;


	//int iii = DEFAULT;

	//pragma(msg, typeof(DC) ); 
	//pragma(msg, typeid(DC) );

	//pragma(msg, typeof(null) ); 
	//pragma(msg, typeid(null) );
	
	//if(isFloatingPoint!float){
		
	//}

	alias _DC = void;
	//VectorT!int vdc0 = _DC;
	VectorT!int vdc0 = void;

	VectorT!int vdc = DC;
	VectorT!int iv2 = IC;
	//Vector vdc = DC;
	//assert(vdc == Float64.init);
	//static assert(Vector(DC) == Float64.init);
	//string vdc_str = vdc.toString;
	//printf(" Vector toString  %.*s  \n",vdc_str.length,vdc_str.ptr);

	Vector v0 = IC;
	assert(v0 == 0.0);


	Vector v1 = 1;
	assert(v1 == 1.0);


	Vector v2 = [1,2,3];
	Vector v3 = Vector(1,2,3);
	assert(v2 == v3 && v3 == Vector(1,2,3));


	string str = Vector(1,2,3).toString;
	printf(" Vector toString  %.*s  \n",str.length,str.ptr);
	
	//pragma(msg, format("[%s,%s,%s]", 1.0,2,3 ) );
	//pragma(msg, Vector(1.465,2.789,3.123) ); 

	//pragma(msg, Vector(1.465,2.789,3.123).toString );
	//pragma(msg, Vector(0.0001,201.0789,3.0123).toString );

	//pragma(msg, Vector(-1.465,-2.789,-3.123).toString );
	//pragma(msg, Vector(-0.0001,-201.0789,-3.0123).toString );

	// pragma(msg, double.init );
	// pragma(msg, ctfe_ftoa(double.init) );

	//pragma(msg, ctfe_ftoa(-1.0/0.0), " " ,ctfe_ftoa(sqrt(-1.0)) );
}

//----------------------------------------------------------
static if(1)
{

Vector some_calc(in Vector v){
	Vector res = v;
	res /= 2;
	return res;
}
static assert(	some_calc(Vector(2,2,2)) == 1.0 );
static assert(	some_calc(Vector(8,4,2)) == Vector(4,2,1) );
static assert(	-Vector(8,4,2)/2 == Vector(-4,-2,-1) );
static assert(	Vector(8,4,2)*2 == Vector(16,8,4) );
static assert(	Vector(8,4,2)+Vector(4,2,1)-Vector(1,1,1) == Vector(11,5,2) );

//static assert(	Len(Vector(1.0,1.0,1.0)) == Sqrt(1.0) );

//pragma(msg,Vector(1.0,1.0,1.0)[2]," "); //do not work 
//pragma(msg,Len(Vector(1.0,1.0,1.0))," ",Sqrt(1.0)); 

void VectorTest()
{
	import std.stdio;
/+
	const Vector c0 = 0.0;
	static assert(	c0.x==0.0 && c0.y==0.0 && c0.z==0.0 );

	//const Vector cd = DC;
	//static assert(	cd.x==0.0 && cd.y==0.0 && cd.z==0.0 );

	const Vector cv  = Vector(1,2,3);
	//static assert(	cv[0]==1 && cv[4]==2 && cv[-1]==3 );
	static assert(	cv[0]==1 && cv[1]==2 && cv[2]==3 );
+/
	//writeln(" ######## VectorTest ######## "); //writeln will CRASH!
	printf(" ######## VectorTest ######## \n");

	Vector v0 = Vector(4,5,6);
	Vector v1 = Vector(1,2,3);

	Vector vr = v0 + v1;
	vr = v0 + 1.0;
	vr = 1.0 + v1;

	vr = Cross(v0,v1);
	float dot = Dot(v0,v1);
	float angle = GetAngle(v0,v1);

	vr += v0;
	vr += 1.0;

	//vr /= v0;
	vr /= 1.0;
	printf(" v0 {%f %f %f} \n",v0.x,v0.y,v0.z);
	printf(" v1 {%f %f %f} \n",v1.x,v1.y,v1.z);
	printf(" vr {%f %f %f} \n",vr.x,vr.y,vr.z);

	printf(" Len %f \n",Len(vr));
	printf(" Len %f \n",Len(Vector(1.0,1.0,1.0)));

	vr[0] = 0.0;
	vr[1] = 1.0;
	vr[2] = 2.0;
	//vr[3] = 3.0;
	printf(" vr {%f %f %f} \n",vr.x,vr.y,vr.z);

	vr[0] += 0.0;  
	vr[1] += 1.0;
	vr[2] += 2.0;
	//vr[3] += 3.0;
	printf(" vr {%f %f %f} \n",vr.x,vr.y,vr.z);

	++vr[0];
	--vr[0];
	vr[0]--;
	//int i; i++;
	printf(" x %f \n",vr[0]);
	printf(" vr {%f %f %f} \n",vr.x,vr.y,vr.z);



	//writeln("{",v1.x," ",v1.y," ",v1.z,"}");
	//pragma(msg,"{",v.x," ",v.y," ",v.z,"}");

	printf(" ----------------------------- \n");
} //VectorTest

}



/+
#include "ge_math.h"	// place before #ifdef

#ifndef __GELVECTOR_H
#define __GELVECTOR_H

struct Vector64
{
Float64 x, y, z;

Vector64() : x(0.0), y(0.0), z(0.0) { }
explicit Vector64(Float64 ix, Float64 iy, Float64 iz)  : x(ix), y(iy), z(iz) { }
explicit Vector64(_DONTCONSTRUCT v) { }
explicit Vector64(const Vector32& v) : x(v.x), y(v.y), z(v.z) { }

#ifndef __LEGACY_API
explicit Vector64(Float64 in) : x(in), y(in), z(in) { }
#else
Vector64(Float64 in) : x(in), y(in), z(in) { }
Float64								 Dot(const Vector32& v) const { return x * Float64(v.x) + y* Float64(v.y) + z* Float64(v.z); }
Float64								 Dot(const Vector64& v2) const { return x * v2.x + y * v2.y + z * v2.z; }
Vector64							 Cross(const Vector64& v2) const { return Vector64(y * v2.z - z * v2.y, z * v2.x - x * v2.z, x * v2.y - y * v2.x); }
inline const Vector32	 ToSV() const { return Vector32((Float32)x, (Float32)y, (Float32)z); }
inline const Vector64& ToLV() const { return *this; }
inline const Vector64& ToRV() const { return *this; }
friend Float64 operator * (const Vector64& v1, const Vector64& v2) { return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z; }
friend const Vector64 operator % (const Vector64& v1, const Vector64& v2) { return Vector64(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x); }
inline const Vector64& operator *= (const Matrix64& m);
inline const Vector64& operator ^= (const Matrix64& m);
const Vector64&				 operator ^= (const Vector64& v) { x *= v.x; y *= v.y; z *= v.z; return *this; }
friend const Vector64 operator ^ (const Vector64& v1, const Vector64& v2) { return Vector64(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z); }
#endif

/// Checks if each component is zero.
Bool IsZero() const
{
return (x == 0.0) && (y == 0.0) && (z == 0.0);
}

/// Checks if one of the components is not zero.
Bool IsNotZero() const
{
return (x != 0.0) || (y != 0.0) || (z != 0.0);
}

/// Sets all components to zero.
void SetZero()
{
x = 0.0;
y = 0.0;
z = 0.0;
}

/// Tests component-wise if the difference is no bigger than 'epsilon'
Bool IsEqual(const Vector64& v2, const Float64& epsilon = 0.01) const
{
return Abs(x - v2.x) < epsilon && Abs(y - v2.y) < epsilon && Abs(z - v2.z) < epsilon;
}

/// Calculates the average value of 'x', 'y' and 'z'
Float64 GetAverage() const
{
return (x + y + z) * (1.0 / 3.0);
}

/// Calculates the sum of 'x', 'y' and 'z'
Float64 GetSum() const
{
return x + y + z;
}

/// Returns the minimum of 'x', 'y' and 'z'
Float64 GetMin() const
{
if (x < y)
{
return (z < x) ? z : x;
}
else
{
return (z < y) ? z : y;
}
}

/// Returns the maximum of 'x', 'y' and 'z'
Float64 GetMax() const
{
if (x > y)
{
return (z > x) ? z : x;
}
else
{
return (z > y) ? z : y;
}
}

/// Returns a vector that is clamped to the range [0.0 .. 1.0]
Vector64 Clamp01() const
{
return Vector64(::Clamp01(x), ::Clamp01(y), ::Clamp01(z));
}

/// Calculates angle (in radians) between v1 and v2
friend Float64 GetAngle(const Vector64& v1, const Vector64& v2)
{
Float64 il = Inverse(v1.GetSquaredLength() * v2.GetSquaredLength());
return ACos((v1.x * v2.x + v1.y * v2.y + v1.z * v2.z) * Sqrt(il));
}

/// Calculates dot product of v1 and v2
friend Float64 Dot(const Vector64& v1, const Vector64& v2)
{
return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
}

/// Calculates cross product of v1 and v2
friend Vector64	Cross(const Vector64& v1, const Vector64& v2)
{
return Vector64(v1.y * v2.z - v1.z * v2.y,
v1.z * v2.x - v1.x * v2.z,
v1.x * v2.y - v1.y * v2.x);
}

/// Returns the length of the vector
Float64	GetLength(void) const
{
return Sqrt(x * x + y * y + z * z);
}

/// Returns the squared length of the vector
Float64	GetSquaredLength(void) const
{
return x * x + y * y + z * z;
}

/// Returns a normalized vector, so that GetLength(vector)==1.0
Vector64 GetNormalized(void) const
{
Float64 l = GetLength();

if (l == 0.0)
return Vector64(0.0, 0.0, 0.0);

l = 1.0 / l;
return Vector64(x * l, y * l, z * l);
}

/// Normalizes this vector, so that GetLength()==1.0
void Normalize(void)
{
Float64 l = Sqrt(x * x + y * y + z * z);
if (l != 0.0)
{
l	 = 1.0 / l;
x *= l;
y *= l;
z *= l;
}
}


const Vector64& operator += (Float64 s)
{
x += s;
y += s;
z += s;
return *this;
}

const Vector64& operator += (const Vector64& v)
{
x += v.x;
y += v.y;
z += v.z;
return *this;
}

const Vector64& operator -= (Float64 s)
{
x -= s;
y -= s;
z -= s;
return *this;
}

const Vector64& operator -= (const Vector64& v)
{
x -= v.x;
y -= v.y;
z -= v.z;
return *this;
}

// multiply each vector component by a scalar
const Vector64& operator *= (Float64 s)
{
x *= s;
y *= s;
z *= s;

return *this;
}

// divide each vector component by a scalar
const Vector64& operator /= (Float64 s)
{
if (s)
{
s	 = 1.0 / s;
x *= s;
y *= s;
z *= s;
}
else
{
x = y = z = 0.0;
}

return *this;
}

#ifndef __LEGACY_API
// multiply vectors componentwise
const Vector64& operator *= (const Vector64& v)
{
x *= v.x; y *= v.y; z *= v.z;
return *this;
}
#endif

// GetLength()
friend Float64 Len(const Vector64& v)
{
return Sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
}

// normalized operator (GetNormalized)
friend const Vector64 operator ! (const Vector64& v)
{
Float64 l = Sqrt(v.x * v.x + v.y * v.y + v.z * v.z);
if (l == 0.0)
return Vector64(0.0);
l = 1.0 / l;
return Vector64(v.x * l, v.y * l, v.z * l);
}

// multiply each vector component by a scalar
friend const Vector64 operator * (Float64 s, const Vector64& v)
{
return Vector64(v.x * s, v.y * s, v.z * s);
}

// multiply each vector component by a scalar
friend const Vector64 operator * (const Vector64& v, Float64 s)
{
return Vector64(v.x * s, v.y * s, v.z * s);
}

// divide each vector component by a scalar
friend const Vector64 operator / (const Vector64& v, Float64 s)
{
if (s)
{
s = 1.0 / s;
return Vector64(v.x * s, v.y * s, v.z * s);
}
return Vector64(0.0);
}

#ifndef __LEGACY_API
// multiply vectors componentwise
friend const Vector64 operator * (const Vector64& v1, const Vector64& v2)
{
return Vector64(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z);
}
#endif

friend const Vector64 operator + (Float64 s, const Vector64& v)
{
return Vector64(v.x + s, v.y + s, v.z + s);
}

friend const Vector64 operator + (const Vector64& v, Float64 s)
{
return Vector64(v.x + s, v.y + s, v.z + s);
}

friend const Vector64 operator + (const Vector64& v1, const Vector64& v2)
{
return Vector64(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

friend const Vector64 operator - (Float64 s, const Vector64& v)
{
return Vector64(s - v.x, s - v.y, s - v.z);
}

friend const Vector64 operator - (const Vector64& v, Float64 s)
{
return Vector64(v.x - s, v.y - s, v.z - s);
}

friend const Vector64 operator - (const Vector64& v1, const Vector64& v2)
{
return Vector64(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
}

friend const Vector64 operator - (const Vector64& v)
{
return Vector64(-v.x, -v.y, -v.z);
}

friend Bool operator == (const Vector64& v1, const Vector64& v2)
{
return (v1.x == v2.x) && (v1.y == v2.y) && (v1.z == v2.z);
}

friend Bool operator == (const Vector64& v1, Float64 r)
{
return (v1.x == r) && (v1.y == r) && (v1.z == r);
}

friend Bool operator != (const Vector64& v1, Float64 r)
{
return (v1.x != r) || (v1.y != r) || (v1.z != r);
}

friend Bool operator != (const Vector64& v1, const Vector64& v2)
{
return (v1.x != v2.x) || (v1.y != v2.y) || (v1.z != v2.z);
}

/// access vector component: index 0 is 'x', index 1 is 'y', index 2 is 'z'. All other values must not be used and will crash
Float64& operator [](Int l)
{
return (&x)[l];
}

/// access vector component: index 0 is 'x', index 1 is 'y', index 2 is 'z'.  All other values must not be used and will crash
const Float64& operator [](Int l) const
{
return (&x)[l];
}
};

#ifdef __LEGACY_API
inline const Vector64 Vector32::ToLV() const { return Vector64((Float64)x, (Float64)y, (Float64)z); }
inline const Vector64 Vector32::ToRV() const { return Vector64((Float64)x, (Float64)y, (Float64)z); }
#endif

#endif


+/


