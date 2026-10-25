# 15º BAEP Virtual JR3 — protótipo interativo

## O que já funciona neste protótipo
- Interface responsiva para celular, em preto, verde-oliva e dourado.
- Navegação entre início, patrulhamentos, operações, efetivo e turnos.
- Pesquisa de registros.
- Formulários de cadastro, edição e exclusão.
- Armazenamento local no navegador via `localStorage`.
- Manifest e service worker iniciais para instalação como PWA quando servido por HTTPS.

## Limitações importantes
Este é um protótipo front-end. O acesso demonstrativo **não é autenticação real**; qualquer pessoa pode abrir o painel neste arquivo. Os dados ficam apenas no navegador em que foram cadastrados e não sincronizam entre celulares. Não use para dados reais ou sensíveis.

## Para tornar o site real
1. Publicar os arquivos num host HTTPS.
2. Criar projeto Supabase.
3. Criar tabelas e políticas RLS para visitantes e administradores.
4. Integrar Supabase Auth; provisionar o primeiro administrador com segurança.
5. Substituir as funções `localStorage` por chamadas ao banco.
6. Testar instalação PWA e permissões antes de divulgar o link.

## Testar localmente
Abra `index.html` no navegador para testar a interface. Para PWA/service worker, é necessário servir os arquivos por HTTPS ou por um servidor local compatível.
