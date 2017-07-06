# -*- coding: utf-8 -

from munch import Munch, munchify
from time import time


def test_registration_data(role, type, tax):
    edrpuo = get_edrpuo(type)
    return munchify(
        {
            "customer_type": role,
            "username": get_email(),
            "password": "123456",
            "registrationcountryname": "1",
            "region": "Київська область",
            "locality": u"Київ",
            "streetaddress": u"вул. Розгуляєва 77",
            "postalcode": "01100",
            "countryName": "Схема UA-EDR",
            "legaltype": convert_by_dict(type),
            "legalname": u"Бла-бла-бла легал нейм",
            "legalname_en": "Bla-bla-bla legal name",
            "identifier": edrpuo,
            "mfo": "123456",
            "bank_account": "123456",
            "bank_branch": "Test Bank Branch",
            "tax": tax,
            "ipn_id": "{}1234".format(edrpuo)[:12],
            "fio": u"Іванов Іван Іванович",
            "userposition": u"СЕО",
            "userdirectiondoc": u"Документ",
            "persons_username": u"Степан",
            "persons_usersurname": u"Степанов",
            "persons_userpatronymic": u"Степанович",
            "persons_username_en": "Stepan",
            "persons_usersurname_en": "Stepanov",
            "persons_email": "test@test.test",
            "persons_telephone": "2222222222",
            "faxNumber": "",
            "mobile": "",
            "url": "",
            "availableLanguage": "",
        }
    )


def get_edrpuo(legal_type):
    if legal_type == "company":
        return str(time()).replace(".","")[3:11]
    else:
        return str(time()).replace(".","")[1:11]


def get_email():
    return "gen_acc{}@byustudio.in.ua".format(str(time()).replace(".",""))


def convert_by_dict(value):
    return {
        "company": "1",
        "sole_trader": "2",
        "person": "3",
    }.get(value)

get_email()