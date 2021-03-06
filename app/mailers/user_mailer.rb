class UserMailer < ActionMailer::Base
  default from: 'Leave Tracker | Nascenia <no-reply@nascenia.com>',
          cc: 'masud@nascenia.com'

  layout 'notification'

  def send_leave_application_notification(user, leave)
    @user = user
    @leave = leave

    if @user.ttf_id
      @ttf = User.find @user.ttf_id
    else
      @ttf = User.find @user.sttf_id
    end

    mail :to => @ttf.email, :subject => "#{@user.name} has applied for a leave"
  end

  def send_approval_or_rejection_notification(leave)
    @leave = leave
    @user = @leave.user

    if @leave.is_accepted?
      subject = 'Leave Approved'
      @title = 'Your leave application has just been approved.'
      @greetings = '- Enjoy your vacation!'
    else
      subject = 'Leave Rejected'
      @title = 'Your leave application has just been rejected.'
      @greetings = '- Better luck next time!'
    end

    mail :to => @user.email, :subject => subject
  end

  def send_unannounced_leave_notification(leave)
    @leave = leave
    @user = @leave.user
    subject = 'Unannounced leave'
    @greetings = '- Have a nice day!'

    mail :to => 'khalid@nascenia.com', :subject => subject
  end
end
