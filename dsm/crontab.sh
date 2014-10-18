#!/bin/sh
#
# Provides missing crontab editing
# Note: Synology crond requires arguments separated by a TAB character
# and the crontab user field only supports root.  These requirements are
# enforced by this script.
#
# John Kelly, 2013-05-03
#
# Amendment history
# JK 2014-01-01.  Added a crontab check/convert option.
# JK 2014-01-03.  Now ignores trailing spaces.
# JK 2014-03-08.  Now ignores multiple consecutive tabs
#
SCRIPTNAME=`basename $0`

# Failed edits or conversions are kept in this file
CHKCRON=/etc/crontab.chk
# Previous version
TMPNAME=/etc/crontab.old
# Max versions to keep.  One or greater
MAXVER=2
# Set to your editor of choice
EDITOR=vi

usage () {
  echo -e "Usage: $SCRIPTNAME [-c | -l | -f | -e | -h]\n"
}

# Basic sanity checks.  Running as root.  One Parameter only.
[[ "`id -u`" =  "0" ]] || ( echo "Root only"; exit 1 )
[[ $# -ne 1 ]] && ( usage; exit 1 )

# Check for selected editor.  Default to vi
EDITOR=`/usr/bin/which $EDITOR`
[[ ! -x "$EDITOR" ]] && EDITOR=/bin/vi

show_help () {
  echo -e "Provides basic access to the crontab file"
  echo -e "with simple format checks.\n"
  usage
  echo    "  -c : Checks current root crontab file for Synology format."
  echo    "  -l : Lists the current contents of the root crontab file."
  echo    "  -f : Refreshes the cron daemon."
  echo    "  -e : Edits the crontab file and refreshes the cron daemon if"
  echo    "       the file is actually changed.  Otherwise does nothing."
  echo -e "  -h : Shows this help text.\n"
  exit 0
}

convert_cron () {
  if check_new; then
    echo "No changes required"
    rm -f $CHKCRON
  else
    echo "Crontab file is NOT in the correct Synology format."
    echo "Please use TABs between fields and specify root in sixth field."
    echo "Your converted version is saved in $CHKCRON."
    echo "Please confirm differences using 'diff /etc/crontab $CHKCRON' before use."
  fi
}

check_new () {
  # Synocron is very picky. Check the file format

  ( # Start of output redirection block
    IFS="
"
    cat /etc/crontab | \
    while read LINE; do
      # Find out if empty or the first character is a #
      echo "${LINE}" | awk '{print $1}' | egrep "^#|^$" >/dev/null 2>&1
      if [[ $? = 0 ]]; then
        # Copy over comment/blank lines exactly
        echo "$LINE"
      else
        unset IFS
        # test convert using tabs to compare results
        # add x to line and remove it later to retain trailing spaces
        # to ensure a correct comparison.
        echo "${LINE}x" | while read MIN HO MD MO WD WH COM; do
          COM=`echo "$COM" | sed 's/x$//'`
          echo -e "$MIN\t$HO\t$MD\t$MO\t$WD\troot\t$COM"
        done
        IFS="
"
      fi
    done
  ) > $CHKCRON # end of output redirection block
  # Compare files and return the result
  /usr/bin/tr -s '\t' '\t' < /etc/crontab >/etc/crontab.test
  /usr/bin/tr -s '\t' '\t' < $CHKCRON > ${CHKCRON}.test
  diff /etc/crontab.test ${CHKCRON}.test >/dev/null 2>&1
  RET=$?
  rm -f /etc/crontab.test ${CHKCRON}.test
  return $RET
}

restart_cron () {
  echo "Refreshing cron daemon."
  /usr/syno/sbin/synoservicectl --restart crond
}

archive () { # Keep up to MAXVER versions
  ARCVER=$MAXVER
  while [[ $ARCVER -gt 1 ]]; do
    PRVVER=`expr $ARCVER - 1`
    mv -f $TMPNAME.$PRVVER $TMPNAME.$ARCVER
    ARCVER=$PRVVER
  done
  cp $TMPNAME ${TMPNAME}.1
}

edit_cron () {
  archive
  cp /etc/crontab ${TMPNAME}
  $EDITOR /etc/crontab
  diff /etc/crontab ${TMPNAME} >/dev/null 2>&1
  if [[ $? = 0 ]]; then
    echo "No changes made.  Doing nothing."
  else
    if check_new; then
      echo "Crontab altered."
      echo "Previous version saved in ${TMPNAME}"
      rm -f $CHKCRON
      restart_cron
    else
      echo "Crontab file is NOT in the correct Synology format."
      echo "Please use TABs between fields and specify root in sixth field."
      echo "Your version is saved in $CHKCRON.  Restoring original version."
      cat /etc/crontab > $CHKCRON
      cat $TMPNAME > /etc/crontab
    fi
  fi
  exit 0
}

### Script flow ###################

while getopts clfhe flag; do
  case $flag in
  c) convert_cron;;
  l) cat /etc/crontab;;
  e) edit_cron;;
  f) restart_cron;;
  h) show_help;;
  ?) usage;;
  esac
done

## End of script flow #############
