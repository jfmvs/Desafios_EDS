import pandas as pd
import pyodbc
import requests


# Lendo do formato CSV:

df = pd.read_csv('exemplo.csv')

# Requisitando de uma API:

url = 'https://exemplo.com/api/procedimentos'
response = requests.get(url)
data = response.json()['procedimentos']
df = pd.DataFrame(data)

# Varíaveis para conectarmos com o servidor SQL
driver = 'SQL Server'
server = 'localhost'
database = 'stg_procedimentos'

# Conexão com o servidor
connection = pyodbc.connect(f'DRIVER={driver};'
                            f'SERVER={server};'
                            f'DATABASE={database};'
                            f'Trusted_Connection=yes;')

cursor = connection.cursor()

# Criando uma tabela de procedimentos em nossa database stg_procedimentos
# Coloquei as colunas a partir da estruturação do banco de dados SIGTAP que consiste de 10 dígitos
cria_tabela = """
CREATE TABLE procedimentos (
    grupo VARCHAR(2),
    subgrupo VARCHAR(2),
    organizacao VARCHAR(2),
    sequencia VARCHAR(3),
    verificador VARCHAR(1)
)
"""

cursor.execute(cria_tabela)

# Inserindo linha a linha em nossa tabela a partir do Dataframe
for index, row in df.iterrows():
    linha = f"""
    INSERT INTO procedimentos (grupo, subgrupo, organizacao, sequencia, verificador)
    VALUES ({row['grupo']}, '{row['subgrupo']}', '{row['organizacao']}', '{row['sequencia']}', '{row['verificador']}')
    """
    cursor.execute(linha)


# Finalizando o processo e a conexão
connection.commit()
cursor.close()
connection.close()