import matplotlib.pyplot as plt

def plot_atendimentos_por_dia(datas):
    # Mapeando atendimentos por dia
    atendimentos = {}
    for date in datas:
        if date in atendimentos:
            atendimentos[date] += 1
        else:
            atendimentos[date] = 1

    # Ordenar as chaves do dicionário por data
    sorted_dates = sorted(atendimentos.keys())

    # Criar listas separadas para as datas e contagens
    x = []
    y = []
    for date in sorted_dates:
        x.append(date)
        y.append(atendimentos[date])
    fig, ax = plt.subplots(figsize=(len(sorted_dates) * 0.5, 6))

    plt.bar(x, y)
    plt.xlabel('Data')
    plt.xticks(rotation=45)
    plt.ylabel('Número de atendimentos')
    plt.title('Atendimentos médicos por dia')
    plt.subplots_adjust(bottom=0.15, left=0.1, right=0.9, top=0.9)
    plt.show()

exemplo_1 = ['2023-05-01', '2023-05-02', '2023-05-02', '2023-05-03', '2023-05-03', '2023-05-03', '2023-05-04']
exemplo_2 = ['2022-04-01', '2022-04-01', '2022-04-01', '2022-04-04', '2022-04-04',  '2022-04-06', '2022-04-07', '2022-04-07','2022-04-07',
          '2022-04-07',  '2022-04-07', '2022-04-12', '2022-04-12', '2022-04-12', '2022-04-15',  '2022-04-15', '2022-04-17','2022-04-18',
          '2022-04-18', '2022-04-18',  '2022-04-21', '2022-04-21', '2022-04-21', '2022-04-21', '2022-04-21',  '2022-04-26', '2022-04-26',
          '2022-04-26', '2022-04-26', '2022-04-26']

plot_atendimentos_por_dia(exemplo_2)

