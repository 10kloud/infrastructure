from infra import Infrastructure


if __name__ == "__main__":
    infra = Infrastructure()
    infra.generate()
    infra.aggregate()
