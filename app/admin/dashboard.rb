ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: -> { I18n.t('active_admin.dashboard') }
end
