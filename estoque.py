def disponivel(prescricao, estoque):
    itens = [item for item in prescricao]
    estoque = [mercadoria for mercadoria in estoque]
    for item in itens:
        if item in estoque:
            estoque.remove(item)
        else:
            return print('Saida: false')
    return print('Saida: true')

medicamentos = 'aba'
estoque = 'cbaa'
disponivel(medicamentos,estoque)