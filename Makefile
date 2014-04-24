all: click-packages

x86_64-package:
	cp -r fonts x86_64/
	cp -r images x86_64/
	cp -r sounds x86_64/
	cp *.json x86_64/
	cp *.png x86_64/
	cp *.desktop x86_64/
	cp *.qml x86_64/
	cp *.qml armhf/
	sed -i 's/all/amd64/g' x86_64/manifest.json 
	click build x86_64

armhf-package:
	cp -r fonts armhf/
	cp -r images armhf/
	cp -r sounds armhf/
	cp *.json armhf/
	cp *.png armhf/
	cp *.desktop armhf/
	cp *.qml armhf/
	sed -i 's/all/armhf/g' armhf/manifest.json 
	click build armhf

click-packages: x86_64-package armhf-package

clean:
	rm *.click
