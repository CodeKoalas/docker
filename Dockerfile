FROM openjdk:8-jdk
MAINTAINER Donnie West "donnie@codekoalas.com"

# Install Deps
RUN apt-get update && apt-get install -y --force-yes expect git wget tar unzip lib32stdc++6 lib32z1

ENV ANDROID_TARGET_SDK="24" \
    ANDROID_BUILD_TOOLS="24.0.2" \
    ANDROID_SDK_TOOLS="24.4.1"

# Install Android SDK
RUN cd /opt && wget --output-document=android-sdk.tgz --quiet http://dl.google.com/android/android-sdk_r${ANDROID_SDK_TOOLS}-linux.tgz && tar xzf android-sdk.tgz && rm -f android-sdk.tgz && chown -R root.root android-sdk-linux

# Setup environment
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN mkdir $ANDROID_HOME/licenses
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 >> $ANDROID_HOME/licenses/android-sdk-license

# Install sdk elements
COPY tools /opt/tools
ENV PATH ${PATH}:/opt/tools
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter android-${ANDROID_TARGET_SDK}
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter platform-tools
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter build-tools-${ANDROID_BUILD_TOOLS}
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter sys-img-armeabi-v7a-android-${ANDROID_TARGET_SDK}
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter extra-google-play-services
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter extra-android-m2repository
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter extra-google-m2repository
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter extra-android-support
RUN echo y | $ANDROID_HOME/tools/android update sdk --all --no-ui --filter addon-google_apis_x86-google-21

RUN which adb
RUN which android

# Create emulator
RUN echo "no" | android create avd \
                --force \
                --device "Nexus 5" \
                --name test \
                --target android-24 \
                --abi armeabi-v7a \
                --skin WVGA800 \
                --sdcard 512M

# Cleaning
RUN apt-get clean

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
