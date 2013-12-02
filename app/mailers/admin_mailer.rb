class AdminMailer < ActionMailer::Base

  default from: "FabLabs <admin_notifications@fablabs.io>"

  def lab_submitted lab_id
    begin
      @lab = Lab.find(lab_id)
      mail(subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}#{@lab} submitted", to: User.admin_emails)
    rescue ActiveRecord::RecordNotFound
    end
  end

  def employee_applied employee_id
    begin
      @employee = Employee.find(employee_id)
      @employee.lab.admins.compact.uniq.each do |admin|
        @admin = admin
        mail(to: admin.email_string, subject: "#{ENV["EMAIL_SUBJECT_PREFIX"]}#{@employee.lab} Employee Application")
      end
    rescue ActiveRecord::RecordNotFound
    end
  end

end
