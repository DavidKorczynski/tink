/**
 * Copyright 2018 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **************************************************************************
 */

#import "TINKMacKeyTemplate.h"

#import "TINKKeyTemplate.h"
#import "core/TINKKeyTemplate_Internal.h"
#import "util/TINKErrors.h"

#include "absl/status/status.h"
#include "tink/mac/mac_key_templates.h"
#include "tink/util/status.h"
#include "proto/tink.pb.h"

@implementation TINKMacKeyTemplate

- (nullable instancetype)initWithKeyTemplate:(TINKMacKeyTemplates)keyTemplate
                                       error:(NSError **)error {
  google::crypto::tink::KeyTemplate *ccKeyTemplate = NULL;
  switch (keyTemplate) {
    case TINKHmacSha256HalfSizeTag:
      ccKeyTemplate = const_cast<google::crypto::tink::KeyTemplate *>(
          &crypto::tink::MacKeyTemplates::HmacSha256HalfSizeTag());
      break;
    case TINKHmacSha256:
      ccKeyTemplate = const_cast<google::crypto::tink::KeyTemplate *>(
          &crypto::tink::MacKeyTemplates::HmacSha256());
      break;
    case TINKHmacSha512HalfSizeTag:
      ccKeyTemplate = const_cast<google::crypto::tink::KeyTemplate *>(
          &crypto::tink::MacKeyTemplates::HmacSha512HalfSizeTag());
      break;
    case TINKHmacSha512:
      ccKeyTemplate = const_cast<google::crypto::tink::KeyTemplate *>(
          &crypto::tink::MacKeyTemplates::HmacSha512());
      break;
    case TINKAesCmac:
      ccKeyTemplate = const_cast<google::crypto::tink::KeyTemplate *>(
          &crypto::tink::MacKeyTemplates::AesCmac());
      break;
    default:
      if (error) {
        *error = TINKStatusToError(crypto::tink::util::Status(
            absl::StatusCode::kInvalidArgument, "Invalid TINKMacKeyTemplate"));
      }
      return nil;
  }
  return (self = [super initWithCcKeyTemplate:ccKeyTemplate]);
}

@end
