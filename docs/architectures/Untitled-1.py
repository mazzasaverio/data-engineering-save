def create_adders():
    adders = []
    for n in range(1, 4):
        adders.append(lambda x: x + n)

    return adders


create_adders()

adders = create_adders()

adders[0](10)
adders[1](10)
adders[2](10)
