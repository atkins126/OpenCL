layout: page
title: "README (Japanese)"
permalink: /

# OpenCL
Parallel computing on the GPU (or CPU) with [OpenCL](https://en.wikipedia.org/wiki/OpenCL).  
[OpenCL](https://ja.wikipedia.org/wiki/OpenCL) を用いたＧＰＵ（やＣＰＵ）での並列計算。  

----
## ■ 1. Structure of the library

### ⬤ 1.1. Parent-Child Relationship：親子関係
> [`TOpenCL`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L60)  
　┃  
[`TCLSystem`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.pas#L60) ：システム  
　┗[`TCLPlatfos`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L88) ：プラットフォームリスト  
　　　┗[`TCLPlatfo`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L33) ：プラットフォーム  
　　　　　┣[`TCLExtenss`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Platfo.pas#L25) ：拡張機能リスト  
　　　　　┣[`TCLDevices`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L291) ：デバイスリスト  
　　　　　┃　┗[`TCLDevice`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Device.pas#L21) ：デバイス  
　　　　　┗[`TCLContexs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L64) ：コンテキストリスト  
　　　　　　　┗[`TCLContex`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Contex.pas#L25) ：コンテキスト  
　　　　　　　　　┣[`TCLQueuers`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L48) ：コマンドキューリスト  
　　　　　　　　　┃　┗[`TCLQueuer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Queuer.pas#L22) ：コマンドキュー  
　　　　　　　　　┣[`TCLArgumes`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L44) ：実引数リスト  
　　　　　　　　　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L26) ：バッファー  
　　　　　　　　　┃　┣[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L26) ：イメージ  
　　　　　　　　　┃　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21) ：サンプラー  
　　　　　　　　　┣[`TCLLibrars`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L234) ：ライブラリリスト  
　　　　　　　　　┃　┗[`TCLLibrar`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L190) ：ライブラリ  
　　　　　　　　　┗[`TCLExecuts`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L245) ：プログラムリスト  
　　　　　　　　　　　┗[`TCLExecut`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L199) ：プログラム  
　　　　　　　　　　　　　┣[`TCLBuildrs`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L76) ：ビルドリスト  
　　　　　　　　　　　　　┃　┗[`TCLBuildr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Progra.pas#L33) ：ビルド  
　　　　　　　　　　　　　┗[`TCLKernels`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L212) ：カーネルリスト  
　　　　　　　　　　　　　　　┗[`TCLKernel`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L105) ：カーネル  
　　　　　　　　　　　　　　　　　┗[`TCLParames`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L65) ：仮引数リスト  
　　　　　　　　　　　　　　　　　　　┗[`TCLParame`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Kernel.pas#L33) ：仮引数

----
## ■ 2. How to use：利用方法
The `TOpenCL` class is a singleton of the `TCLSystem` class.
The `TCLSystem` class automatically detects all **computing devices** on the execution machine.  
`TOpenCL`クラスは、`TCLSystem`クラスのシングルトンです。
`TCLSystem`クラスは、実行マシンにおけるすべての**計算用デバイス**を自動的に検出します。

### ⬤ 2.1. Platform：プラットフォーム
The "**platform**" object (`TCLPlatfo`) represents the environment defined by each device vendor. 
The `TCLSystem` class automatically detects all **platform**s and enumerate them in the `Platfors` property.  
“**プラットフォーム**”オブジェクト (`TCLPlatfo`) は、各デバイスベンダーが定義する環境を表します。
`TCLSystem`クラスは、すべての**プラットフォーム**を自動的に検出し、`Platfors`プロパティに列挙します。 

> Delphi
> ```Delphi
> TOpenCL.Platfors.Count :Integer    // 全プラットフォームの数
> TOpenCL.Platfors[*]    :TCLPlatfo  // 全プラットフォームの配列
> ```

The `TCLPlatfo` class provides information about a specific **platform** as properties.  
`TCLPlatfo`クラスは、特定の**プラットフォーム**に関する情報をプロパティとして提供します。  
> Delphi
> ```Delphi
> _Platfo := TOpenCL.Platfors[0];  // 特定プラットフォームの選択
> 
> _Platfo.Handle        :T_cl_platform_id  // ポインタ
> _Platfo.Profile       :String            // プロファイル
> _Platfo.Version       :String            // バージョン
> _Platfo.Name          :String            // 名前
> _Platfo.Vendor        :String            // ベンダー名
> _Platfo.Extenss.Count :Integer           // 拡張機能の数
> _Platfo.Extenss[*]    :String            // 拡張機能の配列
> ```

### ⬤ 2.2. Device：デバイス
The "**device**" object (`TCLDevice`) represents a physical GPU or CPU.
The `TCLPlatfo` class automatically detects all **device** objects in a specific **platform** object and enumerate them in the `Devices` property.  
**デバイス**オブジェクト (`TCLDevice`) は、物理的なＧＰＵやＣＰＵを表します。
`TCLPlatfo`クラスは、特定の**プラットフォーム**内のすべての**デバイス**を自動的に検出し、`Devices`プロパティに列挙します。  
> Delphi
> ```Delphi
> _Platfo.Devices.Count :Integer    // デバイスの数
> _Platfo.Devices[*]    :TCLDevice  // デバイスの配列
> ```

The `TCLDevice` class provides information about a specific **device** as properties.  
`TCLDevice`クラスは、特定の**デバイス**に関する情報をプロパティとして提供します。  
> Delphi
> ```Delphi
> _Device := _Platfo.Devices[0];  // 特定デバイスの選択
> 
> _Device.Handle           :T_cl_device_id    // ポインタ
> _Device.DEVICE_TYPE      :T_cl_device_type  // タイプ
> _Device.DEVICE_VENDOR_ID :T_cl_uint         // ベンダーＩＤ
> _Device.DEVICE_NAME      :String            // 名前
> _Device.DEVICE_VENDOR    :String            // ベンダー
> _Device.DRIVER_VERSION   :String            // ドライバのバージョン
> _Device.DEVICE_PROFILE   :String            // プロファイル
> _Device.DEVICE_VERSION   :String            // バージョン
> ```

### ⬤ 2.3. Context：コンテキスト
The "**context**" object (`TCLContex`) manages a bundle of related data and programs.
The `TCLContex` class is created from the `TCLPlatfo` class.  
“**コンテキスト**” (`TCLContex`) は、関連するデータやプログラムを束ねて管理します。
`TCLContex`クラスは、`TCLPlatfo`クラスから生成されます。  
> Delphi
> ```Delphi
> _Contex := TCLContex.Create( _Platfo );
>   {or}
> _Contex := _Platfo.Contexs.Add;
> ```

### ⬤ 2.4. Command Queue：コマンドキュー
The "**command queue**" object (`TCLQueuer`) manages the commands sent to the device.
The `TCLQueuer` class is created from the `TCLContex` and the `TCLDevice` classes.  
“**コマンドキュー**”オブジェクト (`TCLQueuer`) は、デバイスに送られる命令を管理します。
`TCLQueuer`クラスは、`TCLContex`クラスと`TCLDevice`クラスから生成されます。  
> Delphi
> ```Delphi
> _Queuer := TCLQueuer.Create( _Contex, _Device );
>   {or}
> _Queuer := _Contex.Queuers.Add( _Device );
> ```

The `TCLContex` class registers the `TCLQueuer` class in the `Queuers` property.  
`TCLQueuer`クラスは、`TCLContex`クラスの`Queuers`プロパティへ登録されます。
> Delphi  
> ```Delphi
> _Contex.Queuers.Count :Integer    // コマンドキューの数
> _Contex.Queuers[*]    :TCLQueuer  // コマンドキューの配列
> ```

Note that **context** and **device** on the different **platforms** cannot generate a **command queue**.  
なお、**プラットフォーム**の異なる**コンテキスト**と**デバイス**からでは、**コマンドキュー**を生成できません。
> Delphi  
> ```Delphi
> P0 := TOpenCL.Platfors[0];
> P1 := TOpenCL.Platfors[1];
> P2 := TOpenCL.Platfors[2];
> 
> D00 := P0.Devices[0];  D01 := P0.Devices[1];  D02 := P0.Devices[2]; 
> D10 := P1.Devices[0];
> D20 := P2.Devices[0];
> 
> C0 := TCLContex.Create( P0 ); 
> C1 := TCLContex.Create( P1 ); 
> C2 := TCLContex.Create( P2 );
> 
> Q00 := TCLQueuer.Create( C0, D00 );  // OK
> Q01 := TCLQueuer.Create( C0, D01 );  // OK
> Q02 := TCLQueuer.Create( C0, D02 );  // OK
> 
> Q10 := TCLQueuer.Create( C1, D00 );  // Error
> Q11 := TCLQueuer.Create( C1, D01 );  // Error
> Q12 := TCLQueuer.Create( C1, D02 );  // Error
> 
> Q20 := TCLQueuer.Create( C2, D00 );  // Error
> Q21 := TCLQueuer.Create( C2, D10 );  // Error
> Q22 := TCLQueuer.Create( C2, D20 );  // OK
> ```

### ⬤ 2.5. Argument：実引数

> [`TCLArgume`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.pas#L21)  
　┣[`TCLMemory`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.pas#L24)  
　┃　┣[`TCLBuffer`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Buffer.pas#L26)  
　┃　┗[`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L26)  
　┗[`TCLSamplr`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Samplr.pas#L21)  

#### ▼ 2.5.1. Memory：メモリー
The "**Memory**" object (`TCLMemory`) stores various data and shares it with the **device**.
The `TCLMemory` class is created from the `TCLContex` and the `TCLQueuer` classes.
The `TCLMemory` class is abstract and derives the `TCLBuffer` and `TCLImager` classes.  
“**メモリー**”オブジェクト (`TCLMemory`) は、様々なデータを格納し**デバイス**と共有します。
`TCLMemory`クラスは、`TCLContex`クラスと`TCLQueuer`クラスから生成されます。
`TCLMemory`クラスは抽象クラスであり、`TCLBuffer`クラスと`TCLImager`クラスを派生させます。  

##### ▽ 2.5.1.1. Buffer：バッファー
The `TCLBuffer` class stores an array of any "simple type" or "record type."  
`TCLBuffer`クラスは、任意の“単純型”や“レコード型”の配列を格納します。
`TCLBuffer`クラスは抽象クラスであり、`TCLDevBuf`クラスと`TCLHosBuf`クラスを派生させます。 

* `TCLDevBuf<TItem>`  
Save the array data to the device side.  
配列データをデバイス側へ保存します。  
* `TCLHosBuf<TItem>`  
Save the array data to the host side.  
配列データをホスト側へ保存します。 

If you want to send an array of the following structures to the device,  
デバイスへ以下のような構造体の配列を送りたい場合、  
> OpenCL C
> ```C
> typedef struct {
>   int    A;
>   double B;
> } TItem;
> 
> kernel void Main( global TItem* Buffer ) {
>   ･･･
> }
> ```

generate the `TCLBuffer` class as follows.  
以下のように`TCLBuffer`クラスを生成します。
> Delphi
> ```Delphi
> TItem = record
>   A :Integer;
>   B :Double;
> end;
> 
> _Buffer := TCLDevBuf<TItem>.Create( _Contex, _Queuer );
>   {or}
> _Buffer := TCLHosBuf<TItem>.Create( _Contex, _Queuer );
> ```
Read and write array data through the `Storag` property.
The array data must be "**map**ped" to synchronize with the host before reading or writing, and "**unmap**ped" to synchronize with the device after use.  
`Storag`プロパティを通して、配列データを読み書きします。
配列データを読み書きする前にホストと同期するために“マップ”し、使用後にデバイスと同期するために“アンマップ”する必要があります。
> Delphi
> ```Delphi
> _Buffer.Count := 3;                            // 要素数の設定
> _Buffer.Storag.Map;                            // メモリ領域を展開
> _Buffer.Storag[0] := TItem.Create( 1, 2.34 );  // 書き込み
> _Buffer.Storag[1] := TItem.Create( 5, 6.78 );  // 書き込み
> _Buffer.Storag[2] := TItem.Create( 9, 0.12 );  // 書き込み
> _Buffer.Storag.Unmap;                          // メモリ領域を同期
> ```

##### ▽ 2.5.1.2. Image：イメージ
The "**image**" object (`TCLImager`) stores the pixel array in 1D to 3D.
3D voxel data is also considered a type of 3D **image**.
The `TCLImager` class is abstract and derives various classes depending on the layout and bits of the color channel.   
“**イメージ**”オブジェクトは、１Ｄ～３Ｄにおけるピクセル配列を格納します。
３Ｄのボクセルデータも**イメージ**の一種と見なされます。
`TCLImager`クラスは抽象クラスであり、カラーチャンネルのレイアウトやビット数に応じて、様々なクラスが派生します。  

> [`TCLImager`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.pas#L26)  
　┣[`TCLImager1D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.pas#L25)  
　┃　┣[`TCLDevIma1DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L30)  
　┃　┃　┣[`TCLDevIma1DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L56)  
　┃　┃　┣[`TCLDevIma1DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L84)  
　┃　┃　┗[`TCLDevIma1DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L112)  
　┃　┗[`TCLHosIma1DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L43)  
　┃　　　┣[`TCLHosIma1DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L70)  
　┃　　　┣[`TCLHosIma1DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L98)  
　┃　　　┗[`TCLHosIma1DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D1.FMX.pas#L126)  
　┣[`TCLImager2D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.pas#L25)  
　┃　┣[`TCLDevIma2DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L30)  
　┃　┃　┣[`TCLDevIma2DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L56)  
　┃　┃　┣[`TCLDevIma2DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L84)  
　┃　┃　┗[`TCLDevIma2DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L112)  
　┃　┗[`TCLHosIma2DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L43)  
　┃　　　┣[`TCLHosIma2DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L70)  
　┃　　　┣[`TCLHosIma2DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L98)  
　┃　　　┗[`TCLHosIma2DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D2.FMX.pas#L126)  
　┗[`TCLImager3D`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.pas#L25)  
　　　┣[`TCLDevIma3DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L30)  
　　　┃　┣[`TCLDevIma3DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L56)  
　　　┃　┣[`TCLDevIma3DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L84)  
　　　┃　┗[`TCLDevIma3DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L112)  
　　　┗[`TCLHosIma3DFMX`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L43)  
　　　　　┣[`TCLHosIma3DxBGRAxUInt8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L70)  
　　　　　┣[`TCLHosIma3DxBGRAxUFix8`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L98)  
　　　　　┗[`TCLHosIma3DxRGBAxSFlo32`](https://github.com/LUXOPHIA/LUX.GPU.OpenCL/blob/master/LUX.GPU.OpenCL.Argume.Memory.Imager.D3.FMX.pas#L126)  

The first part of the class name represents where the `TCLImager` class will store the data.   
クラス名の最初の部分は、`TCLImager`クラスがデータを保存する場所を示しています。  
> * `TCLDevIma*Dx*x*`  
Save the image data to the device side.  
画像データをデバイス側へ保存します。  
> * `TCLHosIma*Dx*x*`  
Save the image data to the host side.  
画像データをホスト側へ保存します。 

The second part of the class name represents the dimension of the `TCLImager` class.  
クラス名の２番目の部分は、`TCLImager`クラスの次元を表しています。  
> * `TCL***Ima1Dx*x*x*`  
Dimension：`1D`
> * `TCL***Ima2Dx*x*x*`  
Dimension：`2D`
> * `TCL***Ima3Dx*x*x*`  
Dimension：`3D`

The third part of the class name represents the channel order of the `TCLImager` class.  
クラス名の３番目の部分は、`TCLImager`クラスのチャンネルの順番を表しています。  
> * `TCL***Ima*xBGRAx*x*`  
Color channel order：`ＢＧＲＡ`
> * `TCL***Ima*xRGBAx*x*`  
Color channel order：`ＲＧＢＡ`

The fourth part of the class name represents the color data type of the `TCLImager` class.  
クラス名の４番目の部分は、`TCLImager`クラスの色のデータ型を表しています。  
> * `TCL***Ima*Dx*xUInt8`  
>   * Device-side data type：`uint8`　@ OpenCL C
>   * Host-side data type：`Byte`　@ Delphi
> * `TCL***Ima*Dx*xUFix8`  
>   * Device-side data type：`float`　@ OpenCL C
>   * Host-side data type：`Byte`　@ Delphi
> * `TCL***Ima*Dx*xSFlo32`  
>   * Device-side data type：`float`　@ OpenCL C
>   * Host-side data type：`Single`　@ Delphi

> Delphi
> ```Delphi
> _Imager := TCLDevIma3DxBGRAxUInt8.Create( _Contex, _Queuer );
> _Imager.CountX := 500;  // Ｘ方向ピクセル数の設定
> _Imager.CountY := 500;  // Ｙ方向ピクセル数の設定
> _Imager.CountY := 500;  // Ｚ方向ピクセル数の設定
> ```

#### ▼ 2.5.2. Sampler：サンプラー
The sampler object (`TCLSamplr`) defines the interpolation method to get the pixel color in real-number coordinates.  
サンプラーオブジェクト (`TCLSamplr`) は、ピクセル色を実数座標で得るための補間方法を定義します。  
> Delphi
> ```Delphi
> _Samplr := TCLSamplr.Create( _Contex );
> ```

### ⬤ 2.6. Program：プログラム
The "**program**" object (`TCLProgra`) reads the source code and builds it into an executable binary.
The `TCLProgra` class is abstract and derives the `TCLLibrar` and `TCLExecut` classes, depending on the type of source code.  
“**プログラム**”オブジェクト (`TCLProgra`) は、ソースコードを読み込んで、実行可能なバイナリへビルドします。
`TCLProgra`クラスは抽象クラスであり、ソースコードの種類に応じて、`TCLLibrar`クラスと`TCLExecut`クラスへ派生します。  

#### ▼ 2.6.1. Library：ライブラリ
The `TCLLibrar` class is a program that does not include functions to execute directly is called a library type.  
`TCLLibrar`クラスは、直接実行する関数を含まないプログラムです。  
> Delphi
> ```Delphi
> _Librar := TCLLibrar.Create( _Contex );
>   {or}
> _Librar := _Contex.Librars.Add;
> 
> _Librar.Source.LoadFromFile( 'Librar.cl' );  // load Sourcecode
> ```

#### ▼ 2.6.2. executable：
The `TCLExecut` class is a program that includes functions (**Kernel**s) to execute directly.  
`TCLExecut`クラスは、直接実行する関数（**カーネル**）を含んだプログラムです。  
> Delphi
> ```Delphi
> _Execut := TCLExecut.Create( _Contex );
>   {or}
> _Execut := _Contex.Executs.Add;
> 
> _Execut.Source.LoadFromFile( 'Execut.cl' );  // load Sourcecode
> ```

### ⬤ 2.7. Build：ビルド
A "**build**" (`TCLBuildr`) is an "action" performed by a **program**, but it is explicitly represented as a class in our library.  
**ビルド** (`TCLBuildr`) は**プログラム**が行う“行為”ですが、我々のライブラリではクラスとして明示的に表現されます。  
> Delphi
> ```Delphi
> _Buildr := _Execut.Buildrs.Add( _Device );
>   {or}
> _Buildr := _Execut.BuildTo( _Device );
> ```

The **kernel** object (see chapter 2.8.) automatically creates the `TCLBuildr` class at runtime.
However, you can check for compiling and linking errors by creating a `TCLBuildr` class before running the kernel.  
**カーネル**オブジェクト（2.8.章参照）は、実行時に`TCLBuildr`クラスを自動生成します。
しかし、カーネルの実行前に`TCLBuildr`クラスを作成することで、コンパイルとリンクのエラーを確認することができます。 
> Delphi
> ```Delphi
> _Buildr.CompileStatus :T_cl_build_status  // コンパイルのスタータス
> _Buildr.CompileLog    :String             // コンパイルのログ
> _Buildr.LinkStatus    :T_cl_build_status  // リンクのスタータス
> _Buildr.LinkLog       :String             // リンクのログ
> ```

### ⬤ 2.8. Kernel：カーネル
The "**kernel**" object (`TCLKernel`) represents an executable function in a program.  
**カーネル**”オブジェクト (`TCLKernel`) は、プログラムの中の実行可能な関数を表します。  
> OpenCL C
> ```C
> kernel void Main( ･･･ ) {
>   ･･･
> }
> ```
The `TCLKernel` class is created from the `TCLExecut` and `TCLQueuer` classes.  
`TCLKernel`クラスは、`TCLExecut`クラスと`TCLQueuer`クラスから生成されます。  
> Delphi
> ```Delphi
> _Kernel := TCLKernel.Create( _Execut, 'Main', _Queuer );
>   {or}
> _Kernel := _Execut.Kernels.Add( 'Main', _Queuer );
> ```


#### ▼ 2.8.1. Parameter：仮引数
The **memory** object connects to the parameter in the source code through the "Parames" property of the `TCLKernel` class.  
**メモリ**オブジェクトは、`TCLKernel`クラスの“Parames”プロパティを介して、ソースコードの引数へ接続します。  
> Delphi
> ```Delphi
> _Kernel.Parames['Buffer'] := _Buffer;  // バッファーの接続
> _Kernel.Parames['Imager'] := _Imager;  // イメージの接続
> _Kernel.Parames['Samplr'] := _Samplr;  // サンプラーの接続
> ```

#### ▼ 2.8.2. Loop Count：反復回数
The OpenCL program repeatedly runs like a triple loop-statement.  
OpenCL のプログラムは、３重のloop文のように繰り返し実行されます。  
> Delphi
> ```Delphi
> _Kernel.GloSizX := 100;  // Ｘ方向のループ回数
> _Kernel.GloSizY := 200;  // Ｙ方向のループ回数
> _Kernel.GloSizY := 300;  // Ｚ方向のループ回数
> ```
You can also specify the minimum and maximum loop indices.  
ループのインデックスの最小値と最大値を指定することもできます。  
> Delphi
> ```Delphi
> _Kernel.GloMinX := 0;      // Ｘ方向の開始インデックス
> _Kernel.GloMinY := 0;      // Ｙ方向の開始インデックス
> _Kernel.GloMinZ := 0;      // Ｚ方向の開始インデックス
> 
> _Kernel.GloMaxX := 100-1;  // Ｘ方向の終了インデックス
> _Kernel.GloMaxY := 200-1;  // Ｙ方向の終了インデックス
> _Kernel.GloMaxZ := 300-1;  // Ｚ方向の終了インデックス
> ```

#### ▼ 2.8.3. Run：実行
> Delphi
> ```Delphi
> _Kernel.Run;  // 実行
> ```

----
## ■ Reference：参考文献
* [The Khronos Group Inc](https://www.khronos.org/)
  * [Khronos OpenCL Registry - The Khronos Group Inc](https://www.khronos.org/registry/OpenCL/)
    * [3.0](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/)
      * [The OpenCL Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_API.html) [`.PDF`](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_API.pdf)
      * [The OpenCL C Specification](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/html/OpenCL_C.html) [`.PDF`](https://www.khronos.org/registry/OpenCL/specs/3.0-unified/pdf/OpenCL_C.pdf)
* [GitHub](https://github.com)
  * [The Khronos Group](https://github.com/KhronosGroup)
    * [OpenCL\-Headers](https://github.com/KhronosGroup/OpenCL-Headers)
----
* **Delphi IDE** @ Embarcadero  
https://www.embarcadero.com/jp/products/delphi/starter