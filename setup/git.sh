git config --global user.name "Matt Chapman"
git config --global user.email "matt@mttchpmn.com"
git config --global core.editor vim
# Actually *run* the command if we mistype it (2 sec delay)
git config --global help.autocorrect 20

cd ~/
git clone git@github.com:mttchpmn/dotfiles.git

cd ~/
mkdir code
cd code

# Wherewolf repositories
git clone git@github.com:wherewolfnz/helperscripts.git
git clone git@github.com:wherewolfnz/docker.git
git clone git@github.com:wherewolfnz/frontend.git
git clone git@github.com:wherewolfnz/wherewolf-backend.git
git clone git@github.com:wherewolfnz/wherewolf-whitelabel.git
git clone git@github.com:wherewolfnz/desmond.git

# Personal Repositories
git clone git@github.com:mttchpmn/MetScope.git
git clone git@github.com:mttchpmn/metscope-frontend.git