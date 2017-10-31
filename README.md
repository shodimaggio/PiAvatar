PiAvatar
====

### MATLAB と小型ロボットで広がる可能性

実世界の物理量を各種センサで取得、サイバー空間に集約してデータを処理・解析し、より
よい社会の実a現に向けてその結果を実世界にフィードバックする。これがIoT、ビッグデー
タ、人工知能(AI)の応用システムに期待される機能の概観といえます。私たちひとりひとりの能
力を補うこと、能力を拡張することもこの期待される機能に含まれるでしょう。

### 千里眼の能力を与えてくれる小型ロボット

Raspberry Pi Zero （以下、Pi Zero）ベースの安価（1 万2 千円程度）な小型ロボットPiAvatarを製しました。
PiAvatar は、Pi Zero とRaspberry Pi Camera モジュール（以下、Pi Camera）
を利用した私たちの分身（Avatar）です。モータを備え、移動できます。バッテリを搭載し、
無線通信ができます。私たちはこの分身を使って離れた場所の様子を知ることができます！
今回、PiAvatar の制御プログラムにはMATLAB を利用しました。Raspberry Pi でプロ
グラミングといえばPython が定番ですが、MATLAB を選択した理由を以下にまとめます。

- 商用製品のためサポート、ドキュメントが充実
- ホストPC からのRaspberry Pi の制御・開発が容易
- 高機能な関数・グラフィックスを利用でき、種類が豊富

Python については既に多くの書籍や記事で取り上げられています。今回、MATLAB での取
り組みを紹介し、皆様の開発オプションを増やすことが出来れば嬉しく思います。

### 小型ロボットPiAvatar の楽しみ方

PiAvatar を製作すればいろいろな楽しみ方ができます。PiAvatar は小型でワイヤレス操作が可能なため、人間が入り難い狭い空間に送り込むことができます。さらに、PiAvatar の機体を自律走行ロボット化することできます。MATLAB/Simulink は、ROS にも対応しています。人工知能に迷路を解かせたり、複数の機体を利用した自動運転の実験も可能でしょう。

### 参考資料

- 20cm以下の床下をらくらく点検!　 Piカメラ偵察ローバ，村松 正吾，CQ出版社，トランジスタ技術，Vol.53，No.12， pp.49-66，2016年12月
- MATLABで開発するカメラ搭載Raspberry Pi Zeroローバー，村松 正吾，MATLAB EXPO 2017講演資料，2017年10月

## 説明

本システムは，機体（ハードウェア）とアプリ（ソフトウェア）で構成されます。
政策の目標は以下の通りです。

### 機体（ハードウェア）
- バッテリー駆動，ワイヤレス通信
- モータで前後左右に移動できる
- カメラで画像を取得できる

### アプリ（ソフトウェア）
- ホストPC上で動作
- 機体を通信制御できる
- 機体からの画像を表示できる

詳しくは [PiAvatar Wiki](https://github.com/shodimaggio/PiAvatar/wiki)を参照してください。

## デモ

最もシンプルなアプリは以下のスクリプトになります。MATLAB コマンドウィンドウ上から実行してください。

- [basic/PiAvatarAppBasic.m](https://github.com/shodimaggio/PiAvatar/blob/master/basic/PiAvatarAppBasic.m)

高機能なアプリは以下のスクリプトになります。MATLAB コマンドウィンドウ上から実行してください。

- [advanced/PiAvatarApp.m](https://github.com/shodimaggio/PiAvatar/blob/master/advanced/PiAvatarApp.m)

以下は自律制御のSimulink モデルになります。Simulink からハードウェアに展開をして利用してください。

- [standalone/AutonomousControlDemo.slx](https://github.com/shodimaggio/PiAvatar/blob/master/standalone/AutonomousControlDemo.slx)


## 使用環境

- MATLAB/Simulink R2017a (Windows 10)
- 
- Image Processing Toolbox
- Computer Vision System Toolbox
- Control System Toolbox


## 使用法

## 準備

詳しくは [PiAvatar Wiki](https://github.com/shodimaggio/PiAvatar/wiki)を参照してください。

## ライセンス

<!-- [MIT](https://github.com/tcnksm/tool/blob/master/LICENCE) -->

## 著者

- [shodimaggio](https://github.com/shodimaggio)
