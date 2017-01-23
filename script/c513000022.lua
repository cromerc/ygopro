--ＴＨＥ　Ｓｕｐｒｅｍａｃｙ　Ｓｕｎ
function c513000022.initial_effect(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c513000022.spr)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51402908,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCondition(c513000022.spcon)
	e3:SetTarget(c513000022.sptg)
	e3:SetOperation(c513000022.spop)
	c:RegisterEffect(e3)
end
function c513000022.spr(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(51402908,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,2)
end
function c513000022.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetTurnID()~=Duel.GetTurnCount() and c:GetFlagEffect(51402908)>0
end
function c513000022.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
	e:GetHandler():ResetFlagEffect(51402908)
end
function c513000022.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
