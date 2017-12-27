source ~/.bashrc
export PATH=/Applications/azprolog.app/Contents/az_home/bin:$PATH
export AZProlog=/Applications/azprolog.app/Contents/az_home
export DYLD_LIBRARY_PATH=/usr/lib:/Applications/azprolog.app/Contents/az_home/lib

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hikalium/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/hikalium/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hikalium/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/hikalium/Downloads/google-cloud-sdk/completion.bash.inc'; fi
