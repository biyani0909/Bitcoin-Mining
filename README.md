Bitcoins (see http://en.wikipedia.org/wiki/Bitcoin) are the most popular
crypto-currency in common use. At their hart, bitcoins use the hardness of cryptographic
hashing (for a reference see http://en.wikipedia.org/wiki/Cryptographic hash function)
to ensure a limited “supply” of coins. In particular, the key component in a bitcoin
is an input that, when “hashed” produces an output smaller than a target
value. In practice, the comparison values have leading 0’s, thus the bitcoin is
required to have a given number of leading 0’s (to ensure 3 leading 0’s, you look
for hashes smaller than 0x001000... or smaller or equal to 0x000ff....
The hash you are required to use is SHA-256. You can check your version
against this online hasher: http://www.xorbin.com/tools/sha256-hash-calculator.
For example, when the text “COP5615 is a boring class” is hashed, the value
0xe9a425077e7b492076b5f32f58d5eb6824b1875621e6237f1a2430c6b77e467c
is obtained. For the coins you find, check your answer with this calculator to
ensure correctness.
The goal of this project is to use Elixir and the actor model to build a
good solution to this problem that runs well on multi-core machines.

Input: The input provided (as command line to your ./project1) will be k,
the required number of 0’s of the bitcoin.

Output: Print, on independent lines, the input string and the corresponding
SHA256 hash separated by a TAB, for each of the bitcoins you find. Obviously,
your SHA256 hash must have the required number of leading 0s (k = 3 means
3 0’s in the hash notation). An extra requirement, to ensure every group finds
different coins, it to have the input string prefixed by the gatorlink ID of one of
the team members.
Example 1:
mix enscript.build
./project1 1
adobra;kjsdfk11 0d402337f95d018438aad6c7dd75ad6e9239d6060444a7a6b26299b261aa9a8b
indicates that the coin with 1 leading 0 is adobra;kjsdfk11 and it is prefixed
by the gatorlink ID vbiyani.

The CPU utilisation should be 350% on a 4core machine.

The project was done under professor Alin Dobra at University of Florida under Distributed System coursework.
