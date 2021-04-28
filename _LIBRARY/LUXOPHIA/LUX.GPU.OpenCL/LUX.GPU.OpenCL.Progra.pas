﻿unit LUX.GPU.OpenCL.Progra;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root,
     LUX.GPU.OpenCL.Kernel;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<_TContext_>

     TCLProgra<_TContext_:class> = class
     private
       type TCLKernel = TCLKernel<_TContext_,TCLProgra<_TContext_>>;
     protected
       _Parent  :_TContext_;
       _Handle  :T_cl_program;
       _Source  :TStringList;
       _LangVer :TCLVersion;
       _Kernels :TObjectList<TCLKernel>;
       ///// アクセス
       procedure SetParent( const Parent_:_TContext_ );
       function GetHandle :T_cl_program;
       procedure SetHandle( const Handle_:T_cl_program );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:_TContext_ ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent  :_TContext_             read   _Parent  write SetParent;
       property Handle  :T_cl_program           read GetHandle  write SetHandle;
       property Source  :TStringList            read   _Source                 ;
       property LangVer :TCLVersion             read   _LangVer                ;
       property Kernels :TObjectList<TCLKernel> read   _Kernels                ;
       ///// メソッド
       procedure Build;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgra<_TContext_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLProgra<_TContext_>.SetParent( const Parent_:_TContext_ );
begin
     if Assigned( _Parent ) then TCLContex( _Parent ).Progras.Remove( TCLProgra( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLContex( _Parent ).Progras.Add   ( TCLProgra( Self ) );
end;

//------------------------------------------------------------------------------

function TCLProgra<_TContext_>.GetHandle :T_cl_program;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLProgra<_TContext_>.SetHandle( const Handle_:T_cl_program );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgra<_TContext_>.CreateHandle;
var
   C :P_char;
   E :T_cl_int;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContex( _Parent ).Handle, 1, @C, nil, @E );

     AssertCL( E );
end;

procedure TCLProgra<_TContext_>.DestroHandle;
begin
     clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgra<_TContext_>.Create;
begin
     inherited;

     _Handle := nil;

     _Source  := TStringList           .Create;
     _Kernels := TObjectList<TCLKernel>.Create;

     _Parent  := nil;
     _LangVer := TCLVersion.From( '2.0' );
end;

constructor TCLProgra<_TContext_>.Create( const Parent_:_TContext_ );
begin
     Create;

     Parent := Parent_;
end;

destructor TCLProgra<_TContext_>.Destroy;
begin
     _Source .Free;
     _Kernels.Free;

      Handle := nil;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgra<_TContext_>.Build;
var
   Ds :TArray<T_cl_device_id>;
   Os :String;
begin
     Ds :=  TCLContex( _Parent ).GetDeviceIDs;

     if Ord( _LangVer ) > 100 then Os := '-cl-std=CL' + _LangVer.ToString
                              else Os := '';

     AssertCL( clBuildProgram( Handle, Length( Ds ), @Ds[0], P_char( AnsiString( Os ) ), nil, nil ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
