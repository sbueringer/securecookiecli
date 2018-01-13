// Copyright © 2018 NAME HERE <EMAIL ADDRESS>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"fmt"
	"github.com/gorilla/securecookie"
	"os"

	"github.com/spf13/cobra"
)

// decryptCmd represents the decrypt command
var decryptCmd = &cobra.Command{
	Use:   "decrypt",
	Short: "Decrypts a securecookie",
	Long: ``,
	Run: func(cmd *cobra.Command, args []string) {
		if args != nil && len(args) == 1 {
			if cookieName == "" {
				cookieName = os.Getenv("COOKIE_NAME")
			}
			if cookieName == "" {
				cmd.Printf("Error: cookie name not set\n\n")
				cmd.Help()
				return
			}

			if cookieHashKey == "" {
				cookieHashKey = os.Getenv("COOKIE_HASH_KEY")
			}
			if cookieHashKey == "" {
				cmd.Printf("Error: cookie hash key not set\n\n")
				cmd.Help()
				return
			}
		
			if cookieBlockKey  == "" {
				cookieBlockKey = os.Getenv("COOKIE_BLOCK_KEY")
			}
		
			decrypt(args[0])
		} else {
			cmd.Printf("Error: argument count is not 1\n\n")
		    cmd.Help()
		}
	},
}

func init() {
	rootCmd.AddCommand(decryptCmd)
}

func decrypt(encryptedContent string){
	var secureCookie *securecookie.SecureCookie
	if cookieBlockKey == "" {
		secureCookie = securecookie.New([]byte(cookieHashKey), nil)
	} else {
		secureCookie = securecookie.New([]byte(cookieHashKey), []byte(cookieBlockKey))
	}

	var content string
	err := secureCookie.Decode(cookieName, encryptedContent, &content)

	if err != nil {
		panic(err)
	}

	fmt.Println(content)
}
