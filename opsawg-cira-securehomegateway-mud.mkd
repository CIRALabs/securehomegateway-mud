---
title: MUD processing and extensions for Secure Home Gateway Project
abbrev: SHG-MUD
docname: draft-richardson-opsawg-securehomegateway-mud-00

# stand_alone: true

ipr: trust200902
area: Internet
wg: 6tisch Working Group
kw: Internet-Draft
cat: info

coding: us-ascii
pi:    # can use array (if all yes) or hash here
  toc: yes
  sortrefs:   # defaults to yes
  symrefs: yes

author:


- ins: M. Richardson
  name: Michael Richardson
  org: Sandelman Software Works
  email: mcr+ietf@sandelman.ca

- ins: J. Latour
  name: Jacques Latour
  org: CIRA Labs
  email: Jacques.Latour@cira.ca

- ins: F. Khan
  name: Faud Khan
  org: Twelve Dot Systems
  email: faud.khan@twelvedot.com

normative:
  RFC2119:
  I-D.ietf-opsawg-mud:

informative:

--- abstract

This document details the mechanism used by the CIRA Secure Home Gateway
and CIRA MUD integration server to return MUD artifacts to participating
gateway systems.

The work in {{I-D.ietf-opsawg-mud}} creates a relationship between a device's
manufacturer and a border gateway that may need to enforce policy.  This
document ads an additional relationship to a service provider, trusted by
the border gateway to enhance or modify the stated security policy.

--- middle

# Introduction

TBD

# Terminology          {#Terminology}

TBD

# Requirements Language {#rfc2119}

In this document, the key words "MUST", "MUST NOT", "REQUIRED",
"SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY",
and "OPTIONAL" are to be interpreted as described in BCP 14, RFC 2119
{{RFC2119}} and indicate requirement levels for compliant STuPiD
implementations.

# Artifacts

TBD

# Security Considerations

TBD.

# IANA Considerations

TBD.

# Acknowledgements

This work was supported by the Canadian Internet Registration Authority (cira.ca).

--- back

