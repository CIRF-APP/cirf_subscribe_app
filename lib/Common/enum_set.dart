/*
success：成功：sessionにログイン情報格納
fail：初期パスワード変更要求など
error：Auth処理でのエラー(ユーザIDやパスワード間違いなども含む)
*/
enum AuthFlowStatus { success, fail, id_error, user_error, pass_error, disable_error, error }

/*
success：成功：トップページに遷移
fail：入力項目不一致など
error：パスワード変更処理でのエラー(sessionなども含む)
*/
enum ChangePassFlowStatus { success, fail, reg_error, input_error, error }

enum SignUpFlowStatus {success, fail}

enum VerificationFlowStatus {success, fail}

enum MusicPageStatus { disabled, modal, smallest }

