--手をつなぐ魔人
function c513000087.initial_effect(c)
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c513000087.tglimit)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c513000087.con)
	e2:SetValue(c513000087.val)
	c:RegisterEffect(e2)
	--only 1 can exists
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_SUMMON)
	e5:SetCondition(c513000087.excon)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetCode(EFFECT_SPSUMMON_CONDITION)
	e7:SetValue(c513000087.splimit)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_SELF_DESTROY)
	e8:SetCondition(c513000087.descon)
	c:RegisterEffect(e8)
end
function c513000087.tglimit(e,c)
	return c~=e:GetHandler()
end
function c513000087.con(e)
	return e:GetHandler():IsDefensePos()
end
function c513000087.val(e,c)
	local def=0
	local g=Duel.GetMatchingGroup(Card.IsFaceup,c:GetControler(),LOCATION_MZONE,0,c)
	local tc=g:GetFirst()
	while tc do
		local cdef=tc:GetDefense()
		def=def+(cdef>=0 and cdef or 0)
		tc=g:GetNext()
	end
	return def
end
function c513000087.exfilter(c,fid)
	return c:IsFaceup() and c:IsCode(100000001) and (fid==nil or c:GetFieldID()<fid)
end
function c513000087.excon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c513000087.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
end
function c513000087.splimit(e,se,sp,st,spos,tgp)
	if bit.band(spos,POS_FACEDOWN)~=0 then return true end
	return not Duel.IsExistingMatchingCard(c513000087.exfilter,tgp,LOCATION_ONFIELD,0,1,nil)
end
function c513000087.descon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c513000087.exfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil,c:GetFieldID())
end
