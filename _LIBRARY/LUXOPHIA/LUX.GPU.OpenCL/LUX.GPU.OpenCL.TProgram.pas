﻿unit LUX.GPU.OpenCL.TProgram;

interface //#################################################################### ■

uses System.Classes, System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgram<_TContext_>

     TCLProgram<_TContext_:class> = class
     private
     protected
       _Parent :_TContext_;
       _Handle :T_cl_program;
       _Source :TStringList;
       ///// アクセス
       procedure SetParent( const Parent_:_TContext_ );
       function GetHandle :T_cl_program;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:_TContext_ ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent   :_TContext_   read   _Parent   write SetParent  ;
       property Handle   :T_cl_program read GetHandle                    ;
       property avHandle :Boolean      read GetavHandle write SetavHandle;
       property Source   :TStringList  read   _Source                    ;
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

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLProgram<_TContext_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

procedure TCLProgram<_TContext_>.SetParent( const Parent_:_TContext_ );
begin
     if Assigned( _Parent ) then TCLContext( _Parent ).Programs.Remove( TCLProgram( Self ) );

                  _Parent := Parent_;

     if Assigned( _Parent ) then TCLContext( _Parent ).Programs.Add   ( TCLProgram( Self ) );
end;

//------------------------------------------------------------------------------

function TCLProgram<_TContext_>.GetHandle :T_cl_program;
begin
     if not TCLContext( _Parent ).avHandle then avHandle := False;

     if not                       avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLProgram<_TContext_>.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLProgram<_TContext_>.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgram<_TContext_>.BeginHandle;
var
   C :P_char;
   E :T_cl_int;
begin
     C := P_char( AnsiString( _Source.Text ) );

     _Handle := clCreateProgramWithSource( TCLContext( _Parent ).Handle, 1, @C, nil, @E );

     AssertCL( E );
end;

procedure TCLProgram<_TContext_>.EndHandle;
begin
     clReleaseProgram( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLProgram<_TContext_>.Create;
begin
     inherited;

     _Source := TStringList.Create;

     _Parent := nil;
     _Handle := nil;
end;

constructor TCLProgram<_TContext_>.Create( const Parent_:_TContext_ );
begin
     Create;

     Parent := Parent_;
end;

destructor TCLProgram<_TContext_>.Destroy;
begin
     if avHandle then EndHandle;

     _Source.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLProgram<_TContext_>.Build;
const
     Os :AnsiString = '-cl-std=CL2.0';
var
   Ds :TArray<T_cl_device_id>;
begin
     Ds :=  TCLContext( _Parent ).GetDevices;

     AssertCL( clBuildProgram( Handle, Length( Ds ), @Ds[0], P_char( Os ), nil, nil ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■