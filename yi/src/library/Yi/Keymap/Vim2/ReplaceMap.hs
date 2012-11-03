module Yi.Keymap.Vim2.ReplaceMap
    ( defReplaceMap
    ) where

import Yi.Buffer
import Yi.Editor
import Yi.Keymap.Keys
import Yi.Keymap.Vim2.Common
import Yi.Keymap.Vim2.Utils

defReplaceMap :: [VimBinding]
defReplaceMap = [escBinding, printable]

escBinding :: VimBinding
escBinding = mkBindingE Replace (spec KEsc, vimMoveE (VMChar Backward), switchMode Normal)

printable :: VimBinding
printable = VimBindingE prereq action
    where prereq _ s = Replace == vsMode s
          action (Event (KASCII c) []) = withBuffer0 $ do
              currentChar <- readB
              if (currentChar == '\n')
                  then insertB c
                  else replaceCharB c
              rightB
          action _ = return ()
