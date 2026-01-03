#!/bin/bash
cd ~/systems-mastery

echo "=== Testing Day 1 extraction ==="
echo "1" > test_day.txt
DAY="1"

awk -v day="$DAY" '
  BEGIN { looking = 0 }
  $0 ~ "^[[:space:]]*Day[[:space:]]+" day "[[:space:]]*:" {
    looking = 1
    topic = $0
    next
  }
  looking {
    if ($0 ~ "^[[:space:]]*Question[[:space:]]*:") {
      gsub(/^[[:space:]]*Question[[:space:]]*:[[:space:]]*/, "", $0)
      question = $0
      next
    }
    if ($0 ~ "^[[:space:]]*AI[[:space:]]+Task[[:space:]]*:") {
      gsub(/^[[:space:]]*AI[[:space:]]+Task[[:space:]]*:[[:space:]]*/, "", $0)
      ai_task = $0
      print "Topic: " topic
      print "Question: " question
      print "AI Task: " ai_task
      exit
    }
  }
' topics.txt

echo ""
echo "=== Testing Day 2 extraction ==="
echo "2" > test_day.txt
DAY="2"

awk -v day="$DAY" '
  BEGIN { looking = 0 }
  $0 ~ "^[[:space:]]*Day[[:space:]]+" day "[[:space:]]*:" {
    looking = 1
    topic = $0
    next
  }
  looking {
    if ($0 ~ "^[[:space:]]*Question[[:space:]]*:") {
      gsub(/^[[:space:]]*Question[[:space:]]*:[[:space:]]*/, "", $0)
      question = $0
      next
    }
    if ($0 ~ "^[[:space:]]*AI[[:space:]]+Task[[:space:]]*:") {
      gsub(/^[[:space:]]*AI[[:space:]]+Task[[:space:]]*:[[:space:]]*/, "", $0)
      ai_task = $0
      print "Topic: " topic
      print "Question: " question
      print "AI Task: " ai_task
      exit
    }
  }
' topics.txt

rm test_day.txt
