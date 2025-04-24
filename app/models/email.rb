class Email < ApplicationRecord
	mount_uploader :pdf, PdfUploader
end
