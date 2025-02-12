function uuid --wraps=python3\ -c\ \"print\(__import__\(\\\"uuid\\\"\).uuid4\(\)\)\" --description alias\ uuid\ python3\ -c\ \"print\(__import__\(\\\"uuid\\\"\).uuid4\(\)\)\"
  python3 -c "print(__import__(\"uuid\").uuid4())" $argv
        
end
