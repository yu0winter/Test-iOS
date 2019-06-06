#!/usr/bin/env bash
bundleName="demo"
bundleDist="dist"
#echo $bundleName
bundleJS='./app/index.js'

echo "\033[32m $bundleName \033[0m"
# 这里的-f参数判断 bundleJS 是否存在
if [ ! -f "$bundleJS" ]; then
    echo "\033[31m $bundleJS 模块不存在 \033[0m"
    exit -1
fi

## mkdir first
mkdir ios
mkdir android

# remove ios
rm -rf ./ios/JDMobile_2.0/bundle/assets/
rm     ./ios/JDMobile_2.0/bundle/$bundleName.bundle
mkdir -p ./ios/JDMobile_2.0/bundle/assets/
# bundle ios
react-native bundle --entry-file $bundleJS \
                    --bundle-output ./ios/JDMobile_2.0/bundle/$bundleName.bundle \
                    --platform ios \
                    --assets-dest ./ios/JDMobile_2.0/bundle \
                    --dev false

#remove android
rm ./android/JDJR/src/main/assets/$bundleName.android.bundle
mkdir -p ./android/JDJR/src/main/assets
# bundle android
react-native bundle --entry-file $bundleJS \
                    --bundle-output ./android/JDJR/src/main/assets/$bundleName.android.bundle \
                    --platform android \
                    --assets-dest ./android/JDJR/src/main/res/ \
                    --dev false


# remove # remove zip
rm -rf ./$bundleDist
mkdir ./$bundleDist
#
# zip jsbundle ios
zip -j ./$bundleDist/$bundleName.ios.bundle.zip ./ios/JDMobile_2.0/bundle/$bundleName.bundle

# zip jsbundle android
zip -j ./$bundleDist/$bundleName.android.bundle.zip ./android/JDJR/src/main/assets/$bundleName.android.bundle


# SHA-256 ios
shasum -a 256 ./ios/JDMobile_2.0/bundle/$bundleName.bundle > ./$bundleDist/key.txt
#shasum -a 256 ./$bundleDist/$bundleName.ios.bundle.zip >> ./$bundleDist/key.txt

# SHA-256 android
shasum -a 256 ./android/JDJR/src/main/assets/$bundleName.android.bundle >>  ./$bundleDist/key.txt
#shasum -a 256 ./$bundleDist/$bundleName.android.bundle.zip >>  ./$bundleDist/key.txt

echo "\033[32m"
cat ./$bundleDist/key.txt
echo "\033[0m"

# 输出H5
npm run prod

cp -r ./web/src_dist/ ./$bundleDist/
