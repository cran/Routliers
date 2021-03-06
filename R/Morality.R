#' Replication of Experiments Evaluating Impact of Psychological Distance on Moral Judgment (Eyal, Liberman & Trope, 2008; Gong & Medin, 2012)
#' Study 2
#'
#' For 6 scenarios, participants have to evaluate the wrongness of actions, with a scale ranging from 1 (not ok) to 5 (completely ok)
#' Contributors: Biljana Jokic Iris Zezelj
#' osf link: https://osf.io/8wqvc/
#'
#' @name Morality
#'
#' @docType data
#'
#' @usage data(Morality)
#'
#' @format a data frame with 145 rows and 10 columns
#' \describe{
#'   \item{number}{participant id}
#'   \item{Orig_rep}{Is participant English or Serbian?}
#'   \item{social_distance}{Is the person in the scenario someone participants know (i.e. colleague, neighbor) ?}
#'   \item{swing_r}{A girl pushing another kid off a swing because she really wants to use it before going home}
#'   \item{flag_r}{A woman cutting it up a national flag into small pieces and using it in order to clean her house}
#'   \item{hands_r}{A man eating his food with his hands, like most of his family members, also in public, after he washes them}
#'   \item{mother_r}{A loving man who promised her dying mother that he would visit her grave every week but didn't keep his  promise because he was very busy}
#'   \item{kiss_r}{Two cousins kissing each other passionately on the mouth, in secret, because there are in love}
#'   \item{dog_r}{Eating our dog that was  hitten  by  a  car  in  front  of  our  house  and  was  killed}
#'   \item{mean_judge_r}{average of all scenarios judgment}
#' }
#'
#' @keywords Brussels Attacks Anxiety Depression Coherence
#'
#'@importFrom stats mahalanobis lm na.omit qchisq
"Morality"
