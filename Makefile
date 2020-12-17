DRAFT:=richardson-mud-qrcode
VERSION:=$(shell ./getver ${DRAFT}.mkd )
PYANG=pyang

${DRAFT}-${VERSION}.txt: ${DRAFT}.txt
	cp ${DRAFT}.txt ${DRAFT}-${VERSION}.txt
	: git add ${DRAFT}-${VERSION}.txt ${DRAFT}.txt

%.xml: %.mkd
	kramdown-rfc2629 ${DRAFT}.mkd >${DRAFT}.xml
	xml2rfc --v2v3 ${DRAFT}.xml
	mv ${DRAFT}.v2v3.xml ${DRAFT}.xml
	: git add ${DRAFT}.xml

%.txt: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --text -o $@ $?

%.html: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --html -o $@ $?

submit: ${DRAFT}.xml
	curl -S -F "user=mcr+ietf@sandelman.ca" -F "xml=@${DRAFT}.xml" https://datatracker.ietf.org/api/submit

version:
	echo Version: ${VERSION}

clean:
	-rm -f ${DRAFT}.xml ${QMUDDATE1}

.PRECIOUS: ${DRAFT}.xml
