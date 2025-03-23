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
    level = nil
    if @current_user.roles.count > 0
      if project_set? && !@current_user.roles.find_by(project_id: @project.id).nil?
        level = @current_user.roles.find_by(project_id: @project.id).authority
      end
    end
    if @current_user.roles.exists?(authority: Role.level.length)
      level = @current_user.roles.find_by(authority: Role.level.length).authority
    end
    if /is_(.+)\?/ !~ calling
      if /at_(.+)_level\?/ !~ calling
        super
      else
        return false if !level                        # ar_role?
        return true if (level == Role.sysadmin)
        if project_set?
          return @current_user.roles.find_by(project_id: @project.id).authority >= Role.level.fetch(:"#{$1.capitalize}")
        else
          return false
        end
      end
    else                                              # is_role?
      return false if !level
      return true if (level == Role.sysadmin)
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
    if project_set? && !user.roles.find_by(project_id: @project.id).nil?
      user.roles.find_by(project_id: @project.id).authority
    else
      Role.tenant
    end
  end
  
  def current_user_project(user)
    if user.roles.find_by(authority: Role.sysadmin)
      return nil
    end
    if project_set?
      @project.id
    else
      nil
    end
  end
                            
  def valid_notices
    if project_set?
      Notification.where('(project_id isnull OR project_id = ' + @project.id.to_s + ') AND valid_from <= "' + Time.zone.today.to_s + '" AND valid_to >= "' + Time.zone.today.to_s + '"')
    else
      Notification.where('project_id isnull AND valid_from <= "' + Time.zone.today.to_s + '" AND valid_to >= "' + Time.zone.today.to_s + '"')
    end        
  end
end