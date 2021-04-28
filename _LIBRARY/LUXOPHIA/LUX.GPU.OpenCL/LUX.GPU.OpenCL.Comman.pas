﻿unit LUX.GPU.OpenCL.Comman;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL.root;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLComman<_TContext_,_TDevice_>

     TCLComman<_TContext_,_TDevice_:class> = class
     private
     protected
       _Parent :_TContext_;
       _Device :_TDevice_;
       _Handle :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       procedure SetHandle( const Handle_:T_cl_command_queue );
       ///// メソッド
       procedure CreateHandle;
       procedure DestroHandle;
     public
       constructor Create; overload;
       constructor Create( const Parent_:_TContext_; const Device_:_TDevice_ ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Parent :_TContext_         read   _Parent                ;
       property Device :_TDevice_          read   _Device                ;
       property Handle :T_cl_command_queue read GetHandle write SetHandle;
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

uses LUX.GPU.OpenCL;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLComman<_TContext_,_TDevice_>

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLComman<_TContext_,_TDevice_>.GetHandle :T_cl_command_queue;
begin
     if not Assigned( _Handle ) then CreateHandle;

     Result := _Handle;
end;

procedure TCLComman<_TContext_,_TDevice_>.SetHandle( const Handle_:T_cl_command_queue );
begin
     if Assigned( _Handle ) then DestroHandle;

     _Handle := Handle_;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLComman<_TContext_,_TDevice_>.CreateHandle;
begin
     {$IF CL_VERSION_2_0 <> 0 }
     _Handle := clCreateCommandQueueWithProperties( TCLContex( _Parent ).Handle, TCLDevice( _Device ).Handle, nil, nil );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( TCLContex( _Parent ).Handle, TCLDevice( _Device ).Handle, nil, nil );
     {$ENDIF}
end;

procedure TCLComman<_TContext_,_TDevice_>.DestroHandle;
begin
     clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLComman<_TContext_,_TDevice_>.Create;
begin
     inherited;

     _Handle := nil;
end;

constructor TCLComman<_TContext_,_TDevice_>.Create( const Parent_:_TContext_; const Device_:_TDevice_ );
begin
     Create;

     _Parent := Parent_;
     _Device := Device_;
end;

destructor TCLComman<_TContext_,_TDevice_>.Destroy;
begin
      Handle := nil;

     TCLContex( _Parent ).Handle := nil;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
