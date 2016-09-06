
# android-java8

This docker is to build Android Gradle project with Java 8.
It is available on Docker Hub https://registry.hub.docker.com/u/jacekmarchwicki/android/ .

Contains:

* Android SDK: r24.4.1
* Build tools: 21, 21.0.1, 21.0.2, 21.1, 21.1.1, 21.1.2, 22, 22.0.1, 23.0.0, 23.0.3, 24.0.2
* Android API: 21, 22, 23, 24
* Support maven repository
* Google maven repository
* Arm emulator: v24
* Platform tools
* Created emulator image named: "Nexus 5"

## Build image

```bash
docker build -t codekoalas/docker-android-java8-ci .
```

If building fail you can debug via where `1b372b1f76f2` is partial build

```bash
docker run --tty --interactive --rm 1b372b1f76f2 /bin/bash
```

## Usage
Change directory to your project directory, than run:

```bash
docker run --tty --interactive --volume=$(pwd):/opt/workspace --workdir=/opt/workspace --rm codekoalas/docker-android-java8-ci /bin/sh -c "./gradlew build"
```

# License

    Copyright [2015]
    
		Contributors:
		 * Jacek Marchwicki  <jacek.marchwicki@gmail.com>
		 * Karol Wojtaszek <karol@appunite.com>
		
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
    	http://www.apache.org/licenses/LICENSE-2.0
        
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
