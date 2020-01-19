﻿unit LUX.GPU.OpenCL.Context;

interface //#################################################################### ■

uses System.Generics.Collections,
     cl_version, cl_platform, cl,
     LUX.Code.C,
     LUX.GPU.OpenCL;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【型】

     TCLCommand = class;
     TCLContext = class;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand

     TCLCommand = class
     private
     protected
       _Context :TCLContext;
       _Device  :TCLDevice;
       _Handle  :T_cl_command_queue;
       ///// アクセス
       function GetHandle :T_cl_command_queue;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create( const Context_:TCLContext; const Device_:TCLDevice );
       destructor Destroy; override;
       ///// プロパティ
       property Context :TCLContext         read   _Context;
       property Device  :TCLDevice          read   _Device ;
       property Handle  :T_cl_command_queue read GetHandle ;  property avHandle :Boolean read GetavHandle write SetavHandle;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext

     TCLContext = class
     private
     protected
       _Commands :TObjectList<TCLCommand>;
       _Handle   :T_cl_context;
       ///// アクセス
       function GetHandle :T_cl_context;
       function GetavHandle :Boolean;
       procedure SetavHandle( const avHandle_:Boolean );
       ///// メソッド
       procedure BeginHandle;
       procedure EndHandle;
     public
       constructor Create; overload;
       constructor Create( const Devices_:TArray<TCLDevice> ); overload;
       destructor Destroy; override;
       ///// プロパティ
       property Commands :TObjectList<TCLCommand> read   _Commands;
       property Handle   :T_cl_context            read GetHandle  ;  property avHandle :Boolean read GetavHandle write SetavHandle;
       ///// メソッド
       procedure Add( const Device_:TCLDevice );
       procedure Remove( const Device_:TCLDevice );
     end;

//const //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【定数】

//var //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【変数】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【レコード】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【クラス】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLCommand

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLCommand.GetHandle :T_cl_command_queue;
begin
     if not _Context.avHandle then avHandle := False;

     if not          avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLCommand.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLCommand.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLCommand.BeginHandle;
begin
     {$IF Declared( CL_VERSION_2_0 ) }
     _Handle := clCreateCommandQueueWithProperties( _Context.Handle, _Device.ID, 0, nil );
     {$ELSE}
     _Handle := clCreateCommandQueue              ( _Context.Handle, _Device.ID, 0, nil );
     {$ENDIF}
end;

procedure TCLCommand.EndHandle;
begin
     clReleaseCommandQueue( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLCommand.Create( const Context_:TCLContext; const Device_:TCLDevice );
begin
     inherited Create;

     _Context := Context_;
     _Device  := Device_;
     _Handle  := nil;
end;

destructor TCLCommand.Destroy;
begin
     if avHandle then EndHandle;

     _Context.avHandle := False;

     inherited;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TCLContext

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

/////////////////////////////////////////////////////////////////////// アクセス

function TCLContext.GetHandle :T_cl_context;
begin
     if not avHandle then BeginHandle;

     Result := _Handle;
end;

function TCLContext.GetavHandle :Boolean;
begin
     Result := Assigned( _Handle );
end;

procedure TCLContext.SetavHandle( const avHandle_:Boolean );
begin
     if avHandle  then EndHandle;

     if avHandle_ then BeginHandle;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext.BeginHandle;
var
   Ds :TArray<T_cl_device_id>;
   I :Integer;
begin
     with _Commands do
     begin
          SetLength( Ds, Count );

          for I := 0 to Count-1 do Ds[ I ] := Items[ I ].Device.ID;

          _Handle := clCreateContext( nil, Count, @Ds[0], nil, nil, nil );
     end;
end;

procedure TCLContext.EndHandle;
begin
     clReleaseContext( _Handle );

     _Handle := nil;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TCLContext.Create;
begin
     inherited;

     _Commands := TObjectList<TCLCommand>.Create;

     _Handle := nil;
end;

constructor TCLContext.Create( const Devices_:TArray<TCLDevice> );
var
   D :TCLDevice;
begin
     Create;

     for D in Devices_ do Add( D );
end;

destructor TCLContext.Destroy;
begin
     if avHandle then EndHandle;

     _Commands.Free;

     inherited;
end;

/////////////////////////////////////////////////////////////////////// メソッド

procedure TCLContext.Add( const Device_:TCLDevice );
begin
     _Commands.Add( TCLCommand.Create( Self, Device_ ) );

     avHandle := False;
end;

procedure TCLContext.Remove( const Device_:TCLDevice );
var
   C :TCLCommand;
begin
     for C in _Commands do
     begin
          if C.Device = Device_ then C.Free;
     end;

     avHandle := False;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【ルーチン】

//############################################################################## □

initialization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 初期化

finalization //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ 最終化

end. //######################################################################### ■
