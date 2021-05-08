# OPENLDAP

```bash
# https://www.openldap.org/doc/admin24/security.html
docker run -p 389:389 -p 636:636 --name openldap --detach osixia/openldap:1.5.0
docker exec openldap ldapsearch -x -H ldap://localhost -b dc=example,dc=org -D "cn=admin,dc=example,dc=org" -w admin


# search
ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn
ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b dc=example,dc=org

# modify
ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f logLevel.ldif

```

```ldif
# structure.ldif
# avec ldapadd pas besoin de préciser le changeType
# ldapadd -x -W -D “cn=admin,dc=mon-entreprise,dc=com” \
#         -H ldap://localhost -f structure.ldif
dn: ou=Personnes,dc=mon-entreprise,dc=com
objectclass: organizationalUnit
ou: Personnes
description: Employes de l entreprise

dn: ou=Machines,dc=mon-entreprise,dc=com
objectclass: organizationalUnit
ou: Machines
description: Ordinateurs de l entreprise

dn: cn=Marie Dupond,ou=Personnes,dc=mon-entreprise,dc=com
objectClass: inetOrgPerson
givenName: Marie
sn: Dupond
cn: Marie Dupond
uid: mdupond
userPassword: mdupond
```

