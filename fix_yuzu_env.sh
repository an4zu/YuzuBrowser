#!/bin/bash

echo "=============================="
echo " 修复 YuzuBrowser 构建环境（最终版）"
echo "=============================="

###############################################
# 1. 修复 build.gradle（彻底删除失效插件）
###############################################

echo "[1/7] 清理失效插件..."

# 删除整行包含 ben-manes 的插件
sed -i '/ben-manes/d' build.gradle

# 删除空插件 id 行
sed -i '/id(""*)/d' build.gradle
sed -i '/id("" )/d' build.gradle
sed -i '/id("")/d' build.gradle

###############################################
# 2. 修复仓库源（jcenter → mavenCentral + jitpack）
###############################################

echo "[2/7] 修复仓库源..."

find . -name "build.gradle" -type f -exec sed -i 's/jcenter()/mavenCentral()/g' {} \;
find . -name "build.gradle" -type f -exec sed -i '/mavenCentral()/a \        maven { url "https://jitpack.io" }' {} \;

###############################################
# 3. 安装 Java
###############################################

echo "[3/7] 安装 OpenJDK 11..."

sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk unzip

###############################################
# 4. 安装 Android Commandline Tools（含 sdkmanager）
###############################################

echo "[4/7] 安装 Android Commandline Tools..."

mkdir -p $HOME/android-sdk/cmdline-tools
cd $HOME/android-sdk/cmdline-tools

# 下载 commandline-tools（Google 官方）
wget https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O tools.zip
unzip tools.zip -d latest
rm tools.zip

export ANDROID_HOME=$HOME/android-sdk
export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH

###############################################
# 5. 安装 Android SDK 平台
###############################################

echo "[5/7] 安装 Android SDK 平台..."

yes | sdkmanager --licenses
yes | sdkmanager "platforms;android-29" "platforms;android-30" "build-tools;30.0.3" "platform-tools"

###############################################
# 6. 返回项目目录并编译
###############################################

echo "[6/7] 开始编译 YuzuBrowser..."

cd /workspaces/YuzuBrowser
chmod +x ./gradlew
./gradlew :browser:assembleDebug --stacktrace

###############################################
# 7. 完成
###############################################

echo "=============================="
echo " 完成！如果编译成功，APK 在："
echo " browser/build/outputs/apk/debug/"
echo "=============================="
