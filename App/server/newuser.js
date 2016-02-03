/**
 * Created by vimukthi on 2/3/16.
 */
Accounts.onCreateUser(function (options, user) {
    user['level'] = 0;
    return user;
})