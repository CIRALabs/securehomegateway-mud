DRAFT:=opsawg-cira-securehomegateway-mud
VERSION:=$(shell ./getver ${DRAFT}.mkd )
YANGDATE=2017-12-11
YANGFILE=cira-shg-mud
QMUDDATE1=yang/${YANGFILE}@${YANGDATE}.yang
PYANG=pyang

${DRAFT}-${VERSION}.txt: ${DRAFT}.txt
	cp ${DRAFT}.txt ${DRAFT}-${VERSION}.txt
	: git add ${DRAFT}-${VERSION}.txt ${DRAFT}.txt

${QMUDDATE1}:: ${YANGFILE}.yang
	mkdir -p yang
	sed -e"s/YYYY-MM-DD/${YANGDATE}/" ${YANGFILE}.yang > ${QMUDDATE1}

${YANG}-tree.txt: ${QMUDDATE1}
	${PYANG} -f tree --path=yang --tree-print-groupings --tree-line-length=70 ${QMUDDATE1} > ${YANGFILE}-tree.txt

%.xml: %.mkd ${QMUDDATE1} ${YANG}-tree.txt
	kramdown-rfc2629 ${DRAFT}.mkd | ./insert-figures >${DRAFT}.xml
	: git add ${DRAFT}.xml

%.txt: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc $? $@

%.html: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --html -o $@ $?

submit: ${DRAFT}.xml
	curl -S -F "user=mcr+ietf@sandelman.ca" -F "xml=@${DRAFT}.xml" https://datatracker.ietf.org/api/submit

version:
	echo Version: ${VERSION}

clean:
	-rm -f ${DRAFT}.xml ${QMUDDATE1}

yang/ietf-mud@2018-06-15.yang:
	mkdir -p yang
	(cd yang && wget https://raw.githubusercontent.com/YangModels/yang/master/experimental/ietf-extracted-YANG-modules/ietf-mud@2018-06-15.yang )

yang/ietf-acldns@2018-06-15.yang:
	mkdir -p yang
	(cd yang && wget https://raw.githubusercontent.com/YangModels/yang/master/experimental/ietf-extracted-YANG-modules/ietf-acldns@2018-06-15.yang )

yang/ietf-access-control-list@2018-04-27.yang:
	mkdir -p yang
	(cd yang && wget https://raw.githubusercontent.com/YangModels/yang/master/experimental/ietf-extracted-YANG-modules/ietf-access-control-list@2018-11-06.yang )

${QMUDDATE1}:: yang/ietf-mud@2018-06-15.yang yang/ietf-acldns@2018-06-15.yang yang/ietf-access-control-list@2018-04-27.yang

.PRECIOUS: ${DRAFT}.xml
