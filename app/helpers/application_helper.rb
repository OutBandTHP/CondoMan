module ApplicationHelper

  def full_title(page_title = '')
    base_title = "CondoMan App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Support 2 query methods of user_roles:
  #   'is_role?'      - verifies if the authority of a given User is of the specific role
  #   'at_role_level' - verifies if the authority of a given User is above a given level  
  def method_missing(calling, *params)
    if @current_user.roles.count > 0
      level = @current_user.roles.first.authority
    else
      level = nil
    end
    if /is_(.+)\?/ !~ calling
      if /at_(.+)_level\?/ !~ calling
        super
      else
        return false if !level
        return true if (calling == :at_admin_level? and level == Role.sysadmin)
        if project_set?
          return @current_user.roles.find_by(project_id: @project.id).authority >= Role.level.fetch(:"#{$1.capitalize}")
        else
          return false
        end
      end
    else                                              # is_role?
      return false if !level
      return true if (calling == :is_sysadmin? and level == Role.sysadmin)
      if project_set?
        return @current_user.roles.find_by(project_id: @project.id).authority == Role.level.fetch(:"#{$1.capitalize}")
      else
        return false
      end     
    end   
  end
    
  def project_set?
    unless session[:project_id].nil?
      @project = Project.find(session[:project_id])
    end
    !session[:project_id].nil?
  end

  def create_user_role(project, user, level, unit=nil)
    role = Role.create(user_id:    user.id,
                       project_id: project.id,
                       unit:       unit,
                       since:      Date.today, 
                       authority:  level)
  end
  
  def current_user_role(user)
    if user.roles.find_by(authority: Role.sysadmin)
      return Role.sysadmin
    end
    if defined?(@project)
      user.roles.find_by(project_id: @project.id).authoruty
    else
      Role.tenant
    end
  end

end