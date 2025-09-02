# Fire Incidents Pipeline 🚒🔥

Pipeline de dados desenvolvido no Databricks para análise de incidentes de incêndio em San Francisco.  

## 📂 Estrutura do Projeto
- `notebooks/Pipeline_FireIncidents.sql`: contém todas as etapas Bronze → Silver → Gold, além da criação de visualizações.

## ⚙️ Tecnologias Utilizadas
- Databricks (Free Edition)
- PySpark / SQL
- Delta Tables
- Unity Catalog (quando disponível)

## 🚀 Como Executar
1. Importe o notebook `Pipeline_FireIncidents.sql` no Databricks.
2. Execute as células na ordem (Bronze → Silver → Gold).
3. Atualize o pipeline de forma incremental para simular cargas diárias.
4. Crie visualizações e dashboards a partir das queries Gold.

## 📝 Decisões Técnicas
- Estrutura Lakehouse: Bronze (raw), Silver (curado), Gold (agregado).
- Incremental Load: uso de `MERGE INTO` para simular cargas diárias.
- Dashboard integrado ao Databricks SQL para visualização.

## ✅ Premissas
- Dados públicos de incidentes de incêndio.
- Execução em Databricks Free Edition (sem cluster persistente).
