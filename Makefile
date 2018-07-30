DRAFT:=opsawg-cira-securehomegateway-mud
VERSION:=$(shell ./getver ${DRAFT}.mkd )
YANGDATE=2017-12-11
#CWTDATE1=yang/ietf-constrained-voucher@${YANGDATE}.yang
#CWTSIDDATE1=ietf-constrained-voucher@${YANGDATE}.sid
#CWTSIDLIST1=ietf-constrained-voucher-sid.txt
#PYANG=./pyang.sh

# git clone this from https://github.com/mbj4668/pyang.git
# then, cd pyang/plugins;
#       wget https://raw.githubusercontent.com/core-wg/yang-cbor/master/sid.py
# sorry.
#PYANGDIR=/sandel/src/pyang

${DRAFT}-${VERSION}.txt: ${DRAFT}.txt
	cp ${DRAFT}.txt ${DRAFT}-${VERSION}.txt
	: git add ${DRAFT}-${VERSION}.txt ${DRAFT}.txt

${CWTDATE1}: ${DRAFT}.yang
	mkdir -p yang
	sed -e"s/YYYY-MM-DD/${YANGDATE}/" ${DRAFT}.yang > ${CWTDATE1}

${DRAFT}-tree.txt: ${CWTDATE1}
	${PYANG} --path=../../anima/voucher/yang:../../anima/bootstrap/yang -f tree --tree-print-groupings --tree-line-length=70 ${CWTDATE1} > ${DRAFT}-tree.txt

%.xml: %.mkd ${CWTDATE1} #${CWTSIDLIST1} 
	kramdown-rfc2629 ${DRAFT}.mkd | ./insert-figures >${DRAFT}.xml
	: git add ${DRAFT}.xml

%.txt: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc $? $@

%.html: %.xml
	unset DISPLAY; XML_LIBRARY=$(XML_LIBRARY):./src xml2rfc --html -o $@ $?

submit: ${DRAFT}.xml
	curl -S -F "user=mcr+ietf@sandelman.ca" -F "xml=@${DRAFT}.xml" https://datatracker.ietf.org/api/submit

${CWTSIDLIST1} ${CWTSIDDATE1}: ${CWTDATE1}
	mkdir -p yang
	${PYANG} --path=../../anima/voucher/yang:../../anima/bootstrap/yang --list-sid --update-sid-file ${CWTSIDDATE1} ${CWTDATE1} | ./truncate-sid-table >${DRAFT}-sid.txt

boot-sid1:
	${PYANG} --path=../../anima/voucher/yang:../../anima/bootstrap/yang --list-sid --generate-sid-yfile 1001100:50 ${CWTDATE1}

version:
	echo Version: ${VERSION}

clean:
	-rm -f ${DRAFT}.xml ${CWTDATE1} ${CWTDATE2}

.PRECIOUS: ${DRAFT}.xml
